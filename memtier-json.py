import os, sys, json

json_path = "./conf/memtier-sample.json" if len(sys.argv) == 1 else sys.argv[1]
json_data = json.loads(open(json_path).read())

memtier_path= "./memtier_benchmark"
cmd = memtier_path

for key, value in json_data.items():
    dash =  "-" if len(key) == 1 else "--"
    cmd += " " + dash + key 

    if dash == "--":
        cmd += "="
    else:
        cmd += " "
        
    cmd += value

os.system(cmd)
