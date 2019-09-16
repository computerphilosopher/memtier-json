import os, sys, json

file_path = "./conf/memtier-sample.json" if len(sys.argv) == 1 else sys.argv[1]
json_data = json.loads(open(file_path).read())

cmd = "./memtier_benchmark"

for key, value in json_data.items():
    dash =  "-" if len(key) == 1 else "--"
    cmd += " " + dash + key 

    if dash == "--":
        cmd += "="
    else:
        cmd += " "
        
    cmd += value

os.system(cmd)
