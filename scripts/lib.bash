run(){
    server=$1
    item_count=$2
    preset=$3
    data_size=$4
    /home/persistence/memtier-json/scripts/vset.bash $server $preset $data_size
}

prepare_test(){
    server=$1 
    repo=$2
    branch=$3
    path=$4
    conf=$5

    ssh persistence@$server "pushd $path/server; git checkout $branch git pull $repo $branch; make;"
    timeout 10 ssh persistence@$server "pushd $path/scripts; ./arcus.sh quicksetup $path/scripts/conf/$conf"
    timeout 3 ssh -t persistence@$server -ic "runserver"
}

finish_test(){
    server=$1 
    service_code=$2
    path=$3
    ssh persistence@$server "$path/scripts/arcus.sh memcached stop $service_code;"
}

vsize(){
    pushd ~/memtier-json/conf
    server=$1
    port=$2
    itemcount=$3
    datasize=$4
    set_rate=$5
    get_rate=$6
    let req=$itemcount/400
    echo { > vsize.json
    echo \"server\":\"$server\", >> vsize.json
    echo \"port\":\"$port\", >> vsize.json
    echo \"threads\":\"10\", >> vsize.json
    echo \"clients\":\"40\", >> vsize.json
    echo \"protocol\":\"memcache_text\", >> vsize.json
    echo \"key-pattern\":\"P:P\", >> vsize.json
    echo \"key-minimum\":\"1\", >> vsize.json
    echo \"key-maximum\":\"$itemcount\", >> vsize.json
    echo \"ratio\":\"$set_rate:$get_rate\", >> vsize.json
    echo \"requests\":\"$req\", >> vsize.json
    echo \"data-size\":\"$datasize\" >> vsize.json
    echo } >> vsize.json

    python $HOME/memtier-json/memtier-json.py ~/memtier-json/conf/vsize.json
    cat vsize.json
}

vrange(){
    pushd ~/memtier-json/conf
    server=$1
    port=$2
    itemcount=$3
    datarange=$4
    set_rate=$5
    get_rate=$6
    
    let req=$itemcount/400
    echo { > vsize.json
    echo \"server\":\"$server\", >> vsize.json
    echo \"port\":\"$port\", >> vsize.json
    echo \"threads\":\"10\", >> vsize.json
    echo \"clients\":\"40\", >> vsize.json
    echo \"protocol\":\"memcache_text\", >> vsize.json
    echo \"key-pattern\":\"P:P\", >> vsize.json
    echo \"key-minimum\":\"1\", >> vsize.json
    echo \"key-maximum\":\"$itemcount\", >> vsize.json
    echo \"ratio\":\"$set_rate:$get_rate\", >> vsize.json
    echo \"requests\":\"$req\", >> vsize.json
    echo \"data-size-range\":\"$datarange\" >> vsize.json
    echo } >> vsize.json

    python $HOME/memtier-json/memtier-json.py ~/memtier-json/conf/vsize.json
    cat vsize.json
}
