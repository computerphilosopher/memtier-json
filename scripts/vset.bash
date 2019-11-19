#~/memtier-json/scripts/before_test.bash $1 persistence

pushd ~/memtier-json/conf
rm vsize.json
touch vsize.json

server=$1
itemcount=$2
datasize=$3

let req=$itemcount/400

echo { >> vsize.json
echo \"server\":\"$server\", >> vsize.json
echo \"port\":\"11911\", >> vsize.json
echo \"threads\":\"10\", >> vsize.json
echo \"clients\":\"40\", >> vsize.json
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

#~/memtier-json/scripts/after_test.bash $1
cat vsize.json
rm vsize.json
echo removed vsize.json
popd
