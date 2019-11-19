#~/memtier-json/scripts/before_test.bash $1 persistence
pushd ~/memtier-json/conf
touch vmix.json

server=$1
itemcount=$2
datasize=$3

let req=$itemcount/400

if [ "$server"="jam2in-m003" ]; then
    let req*=2
fi

echo { >> vmix.json
echo \"server\":\"$server\", >> vmix.json
echo \"port\":\"11911\", >> vmix.json
echo \"threads\":\"10\", >> vmix.json
echo \"clients\":\"40\", >> vmix.json
echo \"protocol\":\"memcache_text\", >> vmix.json
echo \"key-pattern\":\"P:P\", >> vmix.json
echo \"key-minimum\":\"1\", >> vmix.json
echo \"key-maximum\":\"$itemcount\", >> vmix.json
echo \"ratio\":\"1:4\", >> vmix.json
echo \"requests\":\"$req\", >> vmix.json
echo \"data-size\":\"$datasize\" >> vmix.json
echo } >> vmix.json

python $HOME/memtier-json/memtier-json.py ~/memtier-json/conf/vmix.json

echo wait for snapshot...
sleep 10

#~/memtier-json/scripts/after_test.bash $1
cat vmix.json
rm vmix.json
popd
