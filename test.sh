#!/bin/ash
set -e
set -v
echo "test begin"
/ucore/badarg
/ucore/exit
/ucore/forktest
/ucore/matrix
/ucore/spin
/ucore/testbss
/ucore/yield
echo "test end"
