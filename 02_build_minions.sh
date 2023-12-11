#!/bin/bash

# Fuzz all sorts of minions

mkdir std_build
cd std_build
python3 ../configure.py --quick --compiler=$(which afl-clang-fast++)
cd ..

mkdir lib_build
cd lib_build
python3 ../configure.py --quick --lib --compiler=$(which afl-clang-fast++)
cd ..

mkdir asan_build
cd asan_build
export AFL_USE_ASAN=1
python3 ../configure.py --quick --lib --compiler=$(which afl-clang-fast++)
unset AFL_USE_ASAN
cd ..

mkdir msan_build
cd msan_build
export AFL_USE_MSAN=1
python3 ../configure.py --quick --lib --compiler=$(which afl-clang-fast++)
unset AFL_USE_MSAN
cd ..

mkdir ubsan_build
cd ubsan_build
export AFL_USE_UBSAN=1
python3 ../configure.py --quick --lib --compiler=$(which afl-clang-fast++)
unset AFL_USE_UBSAN
cd ..
