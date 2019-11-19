. /home/persistence/mj/scripts/lib.bash
repo=$1
branch=$2
#master evict
ssh persistence@jam2in-m003 "pushd /home/persistence/arcus/server; git checkout $branch; make;"
echo wait before server start
sleep 3 
timeout 10 ssh persistence@jam2in-m003 "pkill mem; /home/persistence/arcus/server/memcached -E /home/persistence/arcus/server/.libs/default_engine.so -X /home/persistence/arcus/server/.libs/syslog_logger.so -X /home/persistence/arcus/server/.libs/ascii_scrub.so -d -v -r -R5 -U 0 -D: -b 8192 -m 6144 -p 11911 -c 3000 -t 6 -z 10.33.19.248:7291"
vrange jam2in-m003 11911 500000 100-48000 1 0

timeout 10 ssh persistence@jam2in-m003 "pkill mem; /home/persistence/arcus/server/memcached -E /home/persistence/arcus/server/.libs/default_engine.so -X /home/persistence/arcus/server/.libs/syslog_logger.so -X /home/persistence/arcus/server/.libs/ascii_scrub.so -d -v -r -R5 -U 0 -D: -b 8192 -m 12288 -p 11911 -c 3000 -t 6 -z 10.33.19.248:7291"

vrange jam2in-m003 11911 500000 100-48000 1 0
