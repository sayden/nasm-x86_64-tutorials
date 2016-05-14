#!/bin/bash

make clean
make all
./$1
echo $?
make clean
