ssh persistence@$1 'pushd /home/persistence/arcus/server; git checkout bspark/persistence_no_expansion; git pull naver persistence; make;'
#ssh persistence@$1 'pushd /home/persistence/arcus-collectd/; ./stop.sh; ./start.sh'
#ssh persistence@$1 'pushd /home/persistence/arcus/server; git pull naver persistence; make; cd engines/default; rm default_engine.conf; touch default_engine.conf; popd'

logsize=256
if ! [ -z "$3" ]; then
    logsize=$3
fi

ssh persistence@$1 "pushd /home/persistence/arcus/server/engines/default;
echo -e 'chkpt_interval_pct_snapshot=50\nchkpt_interval_min_logsize=$logsize\ndata_path=/home/persistence/arcus/server/engines/default/ARCUS-DB\n
logs_path=/home/persistence/arcus/server/engines/default/ARCUS-DB' > default_engine.conf; cat default_engine.conf"

if [ "$2" = "persistence" ]; then
ssh persistence@$1 'pushd /home/persistence/arcus/server/engines/default; echo use_persistence=true >> default_engine.conf; cat default_engine.conf'
else 
ssh persistence@$1 'pushd /home/persistence/arcus/server/engines/default; echo use_persistence=false >> default_engine.conf; cat default_engine.conf'
fi

ssh persistence@$1 'pushd /home/persistence/arcus/server; make'

ssh persistence@$1 'pushd /home/persistence/arcus/server; make'

#ssh persistence@$1 'rm /home/persistence/arcus/server/engines/default/ARCUS-DB/*'

timeout 10 ssh persistence@$1 'pushd /home/persistence/arcus/scripts; ./arcus.sh quicksetup conf/persistence.json'
#timeout 10 ssh persistence@$1 '/home/persistence/arcus/server/memcached -E /home/persistence/arcus/server/.libs/default_engine.so -X /home/persistence/arcus/server/.libs/syslog_logger.so -X /home/persistence/arcus/server/.libs/ascii_scrub.so -e config_file=/home/persistence/arcus/server/engines/default/default_engine.conf -d -v -r -R5 -U 0 -D: -b 8192 -m8192 -p 11911 -c 2000 -t 6 -z 10.33.19.248:7291'

