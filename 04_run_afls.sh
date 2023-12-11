#!/bin/bash
set -x

echo "Making tmux session called afl-fuzz"
export AFL_AUTORESUME=1
export AFL_IGNORE_SEED_PROBLEMS=1
export AFL_SKIP_CPUFREQ=1
export AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1 # probably bad but needed for school systems


tmux new-session -d -s afl-fuzz -n main "AFL_FINAL_SYNC=1 afl-fuzz -M main-$HOSTNAME -D -i test_cases -o fuzz_out -- ./std_build/minion @@"
tmux new-window -n msan -t afl-fuzz: "afl-fuzz -S msan -i test_cases -o fuzz_out -- ./msan_build/minion @@"
tmux new-window -n asan -t afl-fuzz: "afl-fuzz -S asan -i test_cases -o fuzz_out -- ./asan_build/minion @@"
tmux new-window -n ubsan -t afl-fuzz: "afl-fuzz -S ubsan -i test_cases -o fuzz_out -- ./ubsan_build/minion @@"
tmux new-window -n exploit -t afl-fuzz: "afl-fuzz -S exploit -i test_cases -P exploit -o fuzz_out -- ./std_build/minion @@"
