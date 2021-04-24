import json
import os
import sys

transmission_dir=sys.argv[1]

filename = '/etc/transmission-daemon/settings.json'
with open(filename, 'r') as f:
    data = json.load(f)
    data['download-dir'] = transmission_dir+"/transmission/downloaded"
    data["incomplete-dir"]=transmission_dir+"/transmission/incomplete"
    data["incomplete-dir-enabled"]=True
    data["rpc-whitelist"]="*.*.*.*"
    data["rpc-username"]="decoyoctopus"
    data["rpc-password"]="nonninonpiangete"

with open(filename, 'w') as f:
    json.dump(data, f, indent=4)
