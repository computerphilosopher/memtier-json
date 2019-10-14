#!/bin/bash
ssh persistence@jam2in-m001 'pushd /home/persistence/arcus/server; git checkout persistence; git pull naver persistence; make clean && make; popd;'
ssh persistence@jam2in-m001 'pushd /home/persistence/arcus/scripts; ./arcus.sh memcached stop test; ./arcus.sh quicksetup conf/persistence.json; popd;'

python ~/memtier-json/memtier-json.py ~/memtier-json/conf/persistence/snapshot.json && sleep 30 && python ~/memtier-json/memtier-json.py ~/memtier-json/conf/persistence/pretest1.json && sleep 30 && python ~/memtier-json/memtier-json.py ~/memtier-json/conf/persistence/test1.json

snapshot_size=$(ssh persistence@jam2in-m001 'ls -lch /home/persistence/arcus/server/engines/default/ARCUS-DB')

pushd ~/memtier-json/log
memtier_log=$(ls -t1 |  head -n 1)
echo $memtier_log

echo $snapshot_size >> $memtier_log

ssh persistence@jam2in-m001 '/home/persistence/arcus/scripts/arcus.sh stop memcached test' 
