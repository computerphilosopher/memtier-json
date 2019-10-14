~/memtier-json/scripts/before_test.bash persistence

sleep 5

pushd ~/memtier-json/conf
touch vsize.json

itemcount=100000
datasize=100000

if [ ! -z "$1" ]; then
    itemcount=$1
fi
    
if [ ! -z "$2" ]; then
    datasize=$2
fi

let req=$itemcount/1000

echo { >> vsize.json
echo \"server\":\"jam2in-m001\", >> vsize.json
echo \"port\":\"11911\", >> vsize.json
echo \"threads\":\"20\", >> vsize.json
echo \"clients\":\"50\", >> vsize.json
echo \"protocol\":\"memcache_text\", >> vsize.json
echo \"key-pattern\":\"P:P\", >> vsize.json
echo \"key-minimum\":\"1\", >> vsize.json
echo \"key-maximum\":\"$itemcount\", >> vsize.json
echo \"ratio\":\"1:0\", >> vsize.json
echo \"requests\":\"$req\", >> vsize.json
echo \"data-size\":\"$datasize\" >> vsize.json
echo } >> vsize.json

python $HOME/memtier-json/memtier-json.py ~/memtier-json/conf/vsize.json

echo wait for snapshot...
sleep 10

~/memtier-json/scripts/after_test.bash
cat vsize.json
rm vsize.json
popd
