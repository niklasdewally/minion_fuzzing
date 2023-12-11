#!/bin/bash

echo "Making tmux session called afl-session"
export AFL_AUTORESUME=1
export AFL_IGNORE_SEED_PROBLEMS=1
export AFL_SKIP_CPUFREQ=1

tmux new -d -s afl-session afl-fuzz -n main "AFL_FINAL_SYNC=1 afl-fuzz -M main-$HOSTNAME -D -i test_cases -o fuzz_out -- ./std_build/minion @@"
tmux new-window -n msan -t afl-fuzz: "afl-fuzz -S msan -i test_cases -o fuzz_out -- ./msan_build/minion @@"
tmux new-window -n asan -t afl-fuzz: "afl-fuzz -S asan -i test_cases -o fuzz_out -- ./asan_build/minion @@"
tmux new-window -n ubsan -t afl-fuzz: "afl-fuzz -S ubsan -i test_cases -o fuzz_out -- ./ubsan_build/minion @@"
tmux new-window -n exploit -t afl-fuzz: "afl-fuzz -S exploit -i test_cases -P exploit -o fuzz_out -- ./std_build/minion @@"
