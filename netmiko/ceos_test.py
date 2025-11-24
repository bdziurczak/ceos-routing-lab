import json
from pathlib import Path
import subprocess
from netmiko import ConnectHandler


script_dir = Path(__file__).parent
lab_file = script_dir.parent / "topology.clab.yaml"
result = subprocess.run(
    ["clab", "inspect", "-t", lab_file, "-f", "json"],
    capture_output=True, text=True
)

clab_data = json.loads(result.stdout)
lab_name = list(clab_data.keys())[0]

nodes = clab_data[lab_name]
ceos_devices = []

ceos_kind = "arista_ceos"
for node in nodes:
    mgmt_ipv4 = node.get("ipv4_address").split('/')[0]
    device_type = node.get("kind")
    if mgmt_ipv4 and device_type == ceos_kind:
        ceos_devices.append([
            node['name'], 
            {
            'device_type': "arista_eos",
            'host': mgmt_ipv4,
            'username': 'admin',
            'password': 'admin'
           }
        ])

commands = [
    'show ip route | begin Gateway',
    'ping 112.112.115.1', #ping eos2
    'ping 112.112.114.1', #ping eos1
    'ping 192.168.150.129' #ping eos1 lan interface
]        
for dev in ceos_devices:
    print('*******************************************')
    print(f'Connecting to {dev[0]}')
    net_connect = ConnectHandler(**dev[1])
    output = net_connect.send_multiline(commands)
    print(output)
    net_connect.disconnect()
    print('*******************************************')