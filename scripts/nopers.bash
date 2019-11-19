source /home/persistence/memtier-json/scripts/lib.bash
/home/persistence/memtier-json/scripts/before_test.bash $1 no 256
run $1 70000000 13000000 20
./after_test.bash $1
