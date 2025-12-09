# ceos-routing-lab

A Containerlab-based Arista cEOS routing lab for learning, testing, and automating routing scenarios.

**Purpose:** provide a repeatable topology with startup configurations, automation inventory, and helper scripts so you can experiment with routing, peering, and simple LAN/WAN scenarios using Arista cEOS images and lightweight hosts.

**Quick overview**
- **Topology:** defined in `topology.clab.yaml` (annotations in `topology.clab.yaml.annotations.json`).
- **Containerlab layout & data:** under `clab-ceos-routing-lab/` — per-node flash contents, inventory, and topology metadata.
- **Startup configs:** in `configs/` — these are applied to the devices when the lab boots.
- **Helper scripts:** `redeploy.sh` to rebuild the lab, `configs/*-setup.sh` for mock host setup.

**Quick start**

From the repository root:

```bash
# Deploy the lab (this repo includes a convenience script)
./redeploy.sh

# Or directly with containerlab
containerlab deploy -t topology.clab.yaml

# Verify nodes are up
containerlab inspect

# Example: run a simple Netmiko test
source .venv/bin/activate
python3 netmiko/ceos_test.py
```

To destroy the lab:

```bash
containerlab destroy -t topology.clab.yaml
```

**Accessing devices**
- Device connection details are provided by containerlab; you can `ssh` to the node container names or use the Ansible inventory in `clab-ceos-routing-lab/ansible-inventory.yml`.
- The `clab-ceos-routing-lab/authorized_keys` file is used to populate authorized keys in lab devices.

**Repository structure**
- `topology.clab.yaml` — main containerlab topology definition.
- `topology.clab.yaml.annotations.json` — annotations / metadata used by containerlab.
- `redeploy.sh` — convenience wrapper to destroy and redeploy the lab.
- `configs/` — startup configuration files for devices and setup scripts for simulated hosts (LAN/WAN)
	- `*-startup-config.cfg` — device startup configs
	- `lan-pc1-setup.sh`, `lan-pc2-setup.sh`, `wan-simulate-setup.sh` — helper host setup scripts
- `debian-nettools/` — Dockerfile for a container image with network tools (useful for injecting traffic or testing)
- `netmiko/` — example Netmiko script(s) to connect to devices

**Customizing the lab**
- Modify files in `configs/` to change device configurations.
- To persist additional files on a node, place them under `clab-ceos-routing-lab/<node>/flash/` (containerlab bind-mounts these into the node container).
- If you change the topology, update `topology.clab.yaml` and redeploy.


