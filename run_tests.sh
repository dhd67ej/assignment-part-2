#!/bin/bash

THREADS="1 4 8 16 32"
RUNS=3
N=4000
STEPS=100
DT=0.01
FREQ=100

echo "implementation,threads,run,time" > results.csv

for prog in basic red_default red_forces red_all
do
    echo "=============================="
    echo "Testing $prog"
    echo "=============================="

    for t in $THREADS
    do
        for r in $(seq 1 $RUNS)
        do
            echo "Running $prog: threads=$t, run=$r"

            output=$(./$prog $t $N $STEPS $DT $FREQ g)
            time=$(echo "$output" | awk '/Elapsed time/ {print $4}')

            echo "$prog,$t,$r,$time" >> results.csv
        done
    done
done

echo "=============================="
echo "ALL TESTS COMPLETE"
echo "=============================="
cat results.csv
