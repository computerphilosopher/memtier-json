ssh persistence@jam2in-m001 'pushd /home/persistence/arcus/server; git checkout persistence; git pull naver persistence; make; cd engines/default; rm default_engine.conf; touch default_engine.conf; popd'
ssh persistence@jam2in-m001 'pushd /home/persistence/arcus/server/engines/default; rm default_engine.conf; touch default_engine.conf;
echo -e "chkpt_interval_pct_snapshot=100\nchkpt_interval_min_logsize=51200\ndata_path=/home/persistence/arcus/server/engines/default/ARCUS-DB\nlogs_path=/home/persistence/arcus/server/engines/default/ARCUS-DB" >> default_engine.conf'

if [ "$1" = "persistence" ]; then
ssh persistence@jam2in-m001 'pushd /home/persistence/arcus/server/engines/default; echo use_persistence=true >> default_engine.conf && cat default_engine.conf && popd'
else 
ssh persistence@jam2in-m001 'pushd /home/persistence/arcus/server/engines/default; echo use_persistence=false >> default_engine.conf && popd'
fi

ssh persistence@jam2in-m001 'pushd /home/persistence/arcus/server; make ; && popd'
timeout 7 ssh persistence@jam2in-m001 'pushd /home/persistence/arcus/scripts; ./arcus.sh memcached stop test; ./arcus.sh quicksetup conf/persistence.json; popd'
