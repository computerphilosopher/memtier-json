#!/bin/bash

if [ -z "$1" ]; then
    echo no server
    exit 1
fi

run(){
    server=$1
    item_count=$2
    preset=$3
    data_size=$4
    /home/persistence/memtier-json/scripts/vset.bash $server $preset $data_size
    sleep 20
    /home/persistence/memtier-json/scripts/vset.bash $server $item_count $data_size
    sleep 20
    /home/persistence/memtier-json/scripts/vmix.bash $server $item_count $data_size
    /home/persistence/memtier-json/scripts/vmix.bash $server $item_count $data_size
}

all_test() {
    echo $(date) run all test on $1 >> testlog
    echo $(date) no persistence test start >> testlog
    /home/persistence/memtier-json/scripts/before_test.bash $1 no 256
    run $1 70000000 13000000 16
    ./after_test.bash $1
    echo $(date) no persistence test end>> testlog
    sleep 20

    echo $(date) persistence without snapshot start >> testlog
    /home/persistence/memtier-json/scripts/before_test.bash $1 persistence 10240
    run $1 70000000 13000000 16
    ./after_test.bash $1
    echo $(date) persistence without snapshot end >> testlog

    sleep 20
    echo $(date) persistence with snapshot start >> testlog
    /home/persistence/memtier-json/scripts/before_test.bash $1 persistence 256
    run $1 70000000 13000000 16 persistence
    ./after_test.bash $1

    echo $(date) persistence with snapshot end>> testlog
    echo $(date) all test on $1 finished>> testlog
}

all_test $1
