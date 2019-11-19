timeout 7 ssh persistence@$1 'pushd /home/persistence/arcus/server; 
git checkout bspark/origin_expansion; make; /home/persistence/arcus/server/memcached -E /home/persistence/arcus/server/.libs/default_engine.so 
-X /home/persistence/arcus/server/.libs/syslog_logger.so -X /home/persistence/arcus/server/.libs/ascii_scrub.so -d -v -r -R5 -U 0 -D: -b 8192 -m8704 
-p 11911 -c 50000 -t 6 -z 10.34.35.122:7289'

python $HOME/memtier-json/memtier-json.py ~/memtier-json/conf/set.json
ssh persistence@$1 'pkill -f memcached'

sleep 30

ssh persistence@$1 'pushd /home/persistence/arcus/server; 
git checkout bspark/persistence_expansion; make; 
cd engines/default; rm default_engine.conf; touch default_engine.conf'

/home/persistence/memtier-json/scripts/single_vset.bash jam2in-m001 50000000 20 no
sleep 30

/home/persistence/memtier-json/scripts/single_vset.bash jam2in-m001 50000000 20 persistence 
sleep 30

ssh persistence@$1 'pushd /home/persistence/arcus/server; 
git checkout bspark/persistence_no_expansion; make; 
cd engines/default; rm default_engine.conf; touch default_engine.conf'

/home/persistence/memtier-json/scripts/single_vset.bash jam2in-m001 50000000 20 no 
/home/persistence/memtier-json/scripts/single_vset.bash jam2in-m001 50000000 20 persistence

