if [ $# -ne 4 ]; then
    echo check argument
fi

server=$1
threads=$2
clients=$3
itemcount=13000000
datasize=16

~/memtier-json/scripts/before_test.bash $server no

pushd ~/memtier-json/conf
rm vsize.json
touch vsize.json

let req="$itemcount/($threads*$clients)"
#let req=100

echo { >> vsize.json
echo \"server\":\"$server\", >> vsize.json
echo \"port\":\"11911\", >> vsize.json
echo \"threads\":\"$threads\", >> vsize.json
echo \"clients\":\"$clients\", >> vsize.json
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
#sleep 10

pushd ~/memtier-json/log
logfile=$(ls -t | head -n1)
echo $logfile
popd
result=$(cat ~/memtier-json/log/$logfile | grep Totals)
echo $(date) >> ../scripts/con.log

echo $server $threads $clients $result >> ../scripts/con.log
echo "" >> ../scripts/con.log

~/memtier-json/scripts/after_test.bash $server
cat vsize.json
rm vsize.json
echo removed vsize.json
