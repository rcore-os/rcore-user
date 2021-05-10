use crate::syscall::*;
use alloc::boxed::Box;
use alloc::sync::Arc;
use alloc::vec::Vec;
use core::cell::UnsafeCell;
use spin::Mutex;
pub struct Page(UnsafeCell<[u64; 512]>);
use core::sync::atomic::AtomicBool;
unsafe impl Sync for Page {}
struct ThreadControlBlock<T> {
    tid: Mutex<u32>,
    ret: Mutex<Option<T>>, // not really lock
    finished: AtomicBool,
}

impl<T> ThreadControlBlock<T> {
    pub fn new_stub() -> Self {
        ThreadControlBlock {
            tid: Mutex::new(0),
            ret: Mutex::new(None),
            finished: AtomicBool::new(false),
        }
    }
}

struct ThreadRunner<T, F>
where
    F: FnOnce() -> T,
    F: Send + 'static,
    T: Send + 'static,
{
    tcb: Arc<ThreadControlBlock<T>>,
    closure: Option<F>,
    stack: *mut (),
}
pub trait ThreadRun {
    fn run(&mut self) -> *mut ();
}

impl<T, F> ThreadRun for ThreadRunner<T, F>
where
    F: FnOnce() -> T,
    F: Send + 'static,
    T: Send + 'static,
{
    fn run(&mut self) -> *mut () {
        let closure = self.closure.take().expect("you can't run a thread twice!");
        let ret = (closure)();
        let mut r = self.tcb.ret.lock();
        *r = Some(ret);
        drop(r);
        self.tcb
            .finished
            .store(true, core::sync::atomic::Ordering::Release);
        self.stack
    }
}

pub type BoxedThreadRun = Box<dyn ThreadRun>;

fn leak_boxed_thread_run(b: Box<BoxedThreadRun>) -> usize {
    Box::leak(b) as *mut _ as usize
}
fn restore_boxed_thread_run(a: usize) -> Box<BoxedThreadRun> {
    unsafe { Box::from_raw(a as *mut BoxedThreadRun) }
}

extern "C" fn run_boxed_thread(arg: usize) -> i32 {
    let mut boxed_thread_run = restore_boxed_thread_run(arg);
    let stack = boxed_thread_run.run();
    drop(boxed_thread_run);
    extern "C" {
        fn rcore_user_thread_unmmap_and_exit(_stack: usize, _stack_size: usize) -> !;
    }
    unsafe {
        rcore_user_thread_unmmap_and_exit(stack as usize, STACK_SIZE);
    }
}

/// Join handle for thread.
pub struct JoinHandle<T>(Arc<ThreadControlBlock<T>>);

impl<T> JoinHandle<T> {
    pub fn join(self) -> Option<T> {
        while !self.0.finished.load(core::sync::atomic::Ordering::Acquire) {
            core::hint::spin_loop();
        }
        self.0.ret.lock().take()
    }
}

const STACK_SIZE: usize = 16384;

/// Spawn thread.
pub fn spawn<F, T>(f: F) -> JoinHandle<T>
where
    F: FnOnce() -> T,
    F: Send + 'static,
    T: Send + 'static,
{
    let tcb = Arc::new(ThreadControlBlock::new_stub());
    use crate::syscall::{MmapFlags, MmapProt};
    let stack = sys_mmap(
        0,
        STACK_SIZE,
        MmapProt::READ | MmapProt::WRITE,
        MmapFlags::ANONYMOUS | MmapFlags::PRIVATE,
        0,
        0,
    ) as *mut ();
    let runner = ThreadRunner {
        tcb: Arc::clone(&tcb),
        closure: Some(f),
        stack,
    };
    let boxed_runner: Box<BoxedThreadRun> = Box::new(Box::new(runner));
    let runner_arg = leak_boxed_thread_run(boxed_runner);
    let id = sys_clone(run_boxed_thread, stack as usize + STACK_SIZE, 0, runner_arg);
    assert_eq!(id > 0, true);
    *(tcb.tid.lock()) = id;
    JoinHandle(tcb)
}

/// Check whether thread is supported.
pub fn init() {
    extern "C" {
        #[link_name = "rcore_user_thread_init"]
        fn real_init();
    }
    unsafe {
        real_init();
    }
}
