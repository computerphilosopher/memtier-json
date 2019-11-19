snapshot_size=$(ssh persistence@$1 'ls -lsch /home/persistence/arcus/server/engines/default/ARCUS-DB')
echo $snapshot_size
echo $(date) $1 >> sizelog 
echo "$snapshot_size" >> sizelog
echo '' >> sizelog

ssh persistence@$1 '/home/persistence/arcus/scripts/arcus.sh memcached stop test;'

ssh persistence@$1 'rm /home/persistence/arcus/server/engines/default/ARCUS-DB/*; rm /home/persistence/arcus/scripts/ARCUS-DB/*; rm -r /home/persistence/arcus/server/ARCUS-DB/*'
