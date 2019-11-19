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
    sleep 20
    /home/persistence/memtier-json/scripts/vmix.bash $server $item_count $data_size
}

/home/persistence/memtier-json/scripts/before_test.bash $1 persistence 256
run $1 70000000 13000000 16
./after_test.bash $1
