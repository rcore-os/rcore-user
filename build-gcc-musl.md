## step 1: build musl-gcc with gcc-6.4+musl-1.1.21
```
git clone https://github.com/richfelker/musl-cross-make.git
cp config.mak.dist config.mak

# add two line in config.mak
TARGET = x86_64-linux-musl
OUTPUT = /usr/local

make && sudo make install
```

## step 2: remove ubuntu musl* packages
```
sudo apt remove musl*
```

## step 3: use x86_64-linux-musl-gcc to rebuild sfsimg
```
# change rcore_plus/user/biscuit/CMakeLists.txt LINE:35
        set(PREFIX          x86_64-linux-musl-)

cd usr && make clean && make sfsimg arch=x86_64
cd ../kernel && make run arch=x86_64
```

## final test
```
# in qemu
biscuit/ls ##should work now
```
