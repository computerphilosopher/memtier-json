import os, sys, json
from datetime import datetime

MAKE_LOG = True

json_path = "./conf/memtier-sample.json" if len(sys.argv) == 1 else sys.argv[1]
json_data = json.loads(open(json_path).read())

memtier_path= "/home/persistence/memtier_benchmark/memtier_benchmark"
cmd = memtier_path

for key, value in json_data.items():
    dash =  "-" if len(key) == 1 else "--"
    cmd += " " + dash + key 

    if dash == "--":
        cmd += "="
    else:
        cmd += " "
        
    cmd += value

d = datetime.today()
 
if MAKE_LOG:
    #cmd += " > " + os.getcwd() + "/log/" + d.strftime("%Y-%m-%d-%H:%M:%S")
    cmd += " > " + os.path.dirname(os.path.abspath(__file__)) + "/log/" + d.strftime("%Y-%m-%d-%H:%M:%S")

start_time = datetime.today().strftime(d.strftime("%Y-%m-%d-%H:%M:%S"))
os.system(cmd)
end_time = datetime.today().strftime(d.strftime("%Y-%m-%d-%H:%M:%S"))
print(cmd)
print "start: " + start_time
print "end: " + end_time
