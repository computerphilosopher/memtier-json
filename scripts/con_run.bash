pushd ~/memtier-json/scripts


./con_option.bash jam2in-m001 10 20
./con_option.bash jam2in-m001 10 40
./con_option.bash jam2in-m001 50 10


if false; then
    for i in 60 70 80 90 100
    do
        for j in 10 20 30 40 50
        do
            ./con_option.bash jam2in-m001 $i $j
            sleep 20
        done
    done
    popd
fi
