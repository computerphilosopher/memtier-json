snapshot_size=$(ssh persistence@jam2in-m001 'ls -lch /home/persistence/arcus/server/engines/default/ARCUS-DB')

pushd ~/memtier-json/log
memtier_log=$(ls -t1 |  head -n 1)
echo $memtier_log

echo $snapshot_size >> $memtier_log

ssh persistence@jam2in-m001 '/home/persistence/arcus/scripts/arcus.sh memcached stop test;'

rm '/home/persistence/arcus/server/engines/default/default_engine.conf'

ssh persistence@jam2in-m001 'rm /home/persistence/arcus/server/engines/default/ARCUS-DB/*; rm /home/persistence/arcus/scripts/ARCUS-DB/*; rm -r /home/persistence/arcus/server/ARCUS-DB/*'
