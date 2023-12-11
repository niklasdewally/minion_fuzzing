#!/bin/bash

rm -rf all_test_cases test_cases
mkdir -p all_test_cases
cp minion/test_instances/*.minion all_test_cases

afl-cmin -i all_test_cases -o test_cases -- ./std_build/minion @@
