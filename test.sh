#!/bin/ash
# run this with ash test.sh
set -e
set -v
echo "test begin"
# ucore tests
/ucore/badarg
/ucore/exit
/ucore/forktest
/ucore/matrix
/ucore/sleep
/ucore/sleepkill
/ucore/spin
/ucore/testbss
/ucore/yield
echo "test end"
halt -f
