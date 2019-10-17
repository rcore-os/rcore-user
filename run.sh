#!/bin/bash
cd ..
export PATH=$PATH:$PWD/x86_64-linux-musl-cross/bin;
cd user
make sfsimg arch=x86_64