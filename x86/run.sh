#!/bin/bash

make arg=$1 all
./$1
echo "------------------> ${?}"
make arg=$1 clean
