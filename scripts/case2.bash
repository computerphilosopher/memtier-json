#!/bin/bash
./before_test.bash persistence

python ~/memtier-json/memtier-json.py ~/memtier-json/conf/persistence/snapshot.json && sleep 30 && python ~/memtier-json/memtier-json.py ~/memtier-json/conf/persistence/pretest2.json && sleep 30 && python ~/memtier-json/memtier-json.py ~/memtier-json/conf/persistence/test2.json

./after_test.bash
