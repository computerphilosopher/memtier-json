#!/bin/bash

if [-z "$1"]; then
    echo no server
    exit 1
fi
echo $(date) $0 start >> testlog 
echo /home/persistence/memtier-json/scripts/before_test.bash $1 persistence
/home/persistence/memtier-json/scripts/before_test.bash $1 persistence

run(){
    server=$1
    item_count=$2
    preset=$3
    data_size=$4
    /home/persistence/memtier-json/scripts/vset.bash $server $preset $data_size
    ssh persistence@$server 'rm /home/persistence/arcus/server/engines/default/ARCUS-DB/*'
    sleep 20
    /home/persistence/memtier-json/scripts/vset.bash $server $item_count $data_size
    ssh persistence@$server 'rm /home/persistence/arcus/server/engines/default/ARCUS-DB/*'
    sleep 20
    /home/persistence/memtier-json/scripts/vmix.bash $server $item_count $data_size
    ssh persistence@$1 'rm /home/persistence/arcus/server/engines/default/ARCUS-DB/*'
}

run $1 75000000 13000000 20
run $1 7500000 2500000 1000
run $1 750000 200000 10000
run $1 750000 2000 100000
./after_test.bash $1

echo $(date) $0 end >> testlog 

if false; then
    # item size 100
    /home/persistence/memtier-json/scripts/vset.bash $1 13000000 20 
    ssh persistence@$1 'rm /home/persistence/arcus/server/engines/default/ARCUS-DB/*; rm /home/persistence/arcus/scripts/ARCUS-DB/*; rm -r /home/persistence/arcus/server/ARCUS-DB/*'
    sleep 20
    /home/persistence/memtier-json/scripts/vset.bash $1 75000000 20
    ssh persistence@$1 'rm /home/persistence/arcus/server/engines/default/ARCUS-DB/*; rm /home/persistence/arcus/scripts/ARCUS-DB/*; rm -r /home/persistence/arcus/server/ARCUS-DB/*'
    sleep 20
    /home/persistence/memtier-json/scripts/vmix.bash $1 75000000 20
    ssh persistence@$1 'rm /home/persistence/arcus/server/engines/default/ARCUS-DB/*; rm /home/persistence/arcus/scripts/ARCUS-DB/*; rm -r /home/persistence/arcus/server/ARCUS-DB/*'

    # item size 1000
    /home/persistence/memtier-json/scripts/vset.bash $1 2500000 1000 
    ssh persistence@$1 'rm /home/persistence/arcus/server/engines/default/ARCUS-DB/*; rm /home/persistence/arcus/scripts/ARCUS-DB/*; rm -r /home/persistence/arcus/server/ARCUS-DB/*'
    sleep 20
    /home/persistence/memtier-json/scripts/vset.bash $1 7500000 1000
    ssh persistence@$1 'rm /home/persistence/arcus/server/engines/default/ARCUS-DB/*; rm /home/persistence/arcus/scripts/ARCUS-DB/*; rm -r /home/persistence/arcus/server/ARCUS-DB/*'
    sleep 20
    /home/persistence/memtier-json/scripts/vmix.bash $1 7500000 1000
    ssh persistence@$1 'rm /home/persistence/arcus/server/engines/default/ARCUS-DB/*; rm /home/persistence/arcus/scripts/ARCUS-DB/*; rm -r /home/persistence/arcus/server/ARCUS-DB/*'

    # item size 10000
    /home/persistence/memtier-json/scripts/vset.bash $1 200000 10000 
    ssh persistence@$1 'rm /home/persistence/arcus/server/engines/default/ARCUS-DB/*; rm /home/persistence/arcus/scripts/ARCUS-DB/*; rm -r /home/persistence/arcus/server/ARCUS-DB/*'
    sleep 20
    /home/persistence/memtier-json/scripts/vset.bash $1 750000 10000
    ssh persistence@$1 'rm /home/persistence/arcus/server/engines/default/ARCUS-DB/*; rm /home/persistence/arcus/scripts/ARCUS-DB/*; rm -r /home/persistence/arcus/server/ARCUS-DB/*'
    sleep 20
    /home/persistence/memtier-json/scripts/vmix.bash $1 750000 10000
    ssh persistence@$1 'rm /home/persistence/arcus/server/engines/default/ARCUS-DB/*; rm /home/persistence/arcus/scripts/ARCUS-DB/*; rm -r /home/persistence/arcus/server/ARCUS-DB/*'

    # item size 100000
    /home/persistence/memtier-json/scripts/vset.bash $1 20000 100000 
    ssh persistence@$1 'rm /home/persistence/arcus/server/engines/default/ARCUS-DB/*; rm /home/persistence/arcus/scripts/ARCUS-DB/*; rm -r /home/persistence/arcus/server/ARCUS-DB/*'
    sleep 20
    /home/persistence/memtier-json/scripts/vset.bash $1 750000 100000
    ssh persistence@$1 'rm /home/persistence/arcus/server/engines/default/ARCUS-DB/*; rm /home/persistence/arcus/scripts/ARCUS-DB/*; rm -r /home/persistence/arcus/server/ARCUS-DB/*'
    sleep 20
    /home/persistence/memtier-json/scripts/vmix.bash $1 750000 100000
    ssh persistence@$1 'rm /home/persistence/arcus/server/engines/default/ARCUS-DB/*; rm /home/persistence/arcus/scripts/ARCUS-DB/*; rm -r /home/persistence/arcus/server/ARCUS-DB/*'

    ./after_test.bash $1
fi

