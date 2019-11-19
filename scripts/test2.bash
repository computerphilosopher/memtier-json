#!/bin/bash

if [ -z "$1" ]; then
    echo no server
    exit 1
fi
echo $(date) $1 $0 start >> testlog 
#echo /home/persistence/memtier-json/scripts/before_test.bash $1 persistence
#/home/persistence/memtier-json/scripts/before_test.bash $1 persistence

/home/persistence/memtier-json/scripts/vset.bash $1 13000000 20 
ssh persistence@$1 'rm /home/persistence/arcus/server/engines/default/ARCUS-DB/*; rm /home/persistence/arcus/scripts/ARCUS-DB/*; rm /home/persistence/arcus/server/ARCUS-DB/*'
sleep 20
/home/persistence/memtier-json/scripts/vset.bash $1 75000000 20
ssh persistence@$1 'rm /home/persistence/arcus/server/engines/default/ARCUS-DB/*; rm /home/persistence/arcus/scripts/ARCUS-DB/*; rm /home/persistence/arcus/server/ARCUS-DB/*'
sleep 20
/home/persistence/memtier-json/scripts/vmix.bash $1 75000000 20

#./after_test.bash $1
#echo $(date) $1 $0 end >> testlog 
