#!/bin/bash

# Fuzz all sorts of minions

CONFIGURE=$(realpath minion/configure.py)
mkdir -p std_build
cd std_build
python3 $CONFIGURE --quick --compiler=$(which afl-clang-fast++)
nice make 
cd ..

mkdir -p lib_build
cd lib_build
python3 $CONFIGURE --quick --lib --compiler=$(which afl-clang-fast++)
nice make 
cd ..

mkdir -p asan_build
cd asan_build
export AFL_USE_ASAN=1
python3 $CONFIGURE --quick --lib --compiler=$(which afl-clang-fast++)
nice make 
unset AFL_USE_ASAN
cd ..

mkdir -p msan_build
cd msan_build
export AFL_USE_MSAN=1
python3 $CONFIGURE --quick --lib --compiler=$(which afl-clang-fast++)
nice make 
unset AFL_USE_MSAN
cd ..

mkdir -p ubsan_build
cd ubsan_build
export AFL_USE_UBSAN=1
python3 $CONFIGURE --quick --lib --compiler=$(which afl-clang-fast++)
nice make 
unset AFL_USE_UBSAN
cd ..
