## Info

MacOS wrapper for running [https://github.com/itzg/docker-minecraft-bedrock-server](https://github.com/itzg/docker-minecraft-bedrock-server) in a local Kubernetes cluster.

Requires Docker Desktop with Kubernetes enabled.

## Usage

Use make commands to interact with the server.

```sh
$ make
target                         help
------                         ----
help                           Show this help
start                          Start server
stop                           Stop server
restart                        Restart server
logs                           See server logs
bash                           Exec bash in the server pod
config                         Configure server once running
```

### Start

```sh
$ make start
namespace/minecraft-server created
configmap/minecraft-bedrock created
statefulset.apps/bds created
service/bds created
==> Running on port 19132
```

### Stop

```sh
$ make stop
namespace "minecraft-server" deleted
```

### Logs

```sh
$ make logs
DEBU[0000] Using /data to match uid and gid             
DEBU[0000] Resolved UID=0 from match path               
DEBU[0000] Resolved GID=0 from match path               
Looking up latest version...
Starting Bedrock server...
NO LOG FILE! - setting up server logging...
[2024-02-08 06:26:47:283 INFO] Starting Server
[2024-02-08 06:26:47:283 INFO] Version: 1.20.61.01
[2024-02-08 06:26:47:283 INFO] Session ID: 3f462c35-b3d7-4b6f-bc79-698e62f6c4f6
[2024-02-08 06:26:47:283 INFO] Build ID: 21637155
[2024-02-08 06:26:47:283 INFO] Branch: r/20_u6
[2024-02-08 06:26:47:283 INFO] Commit ID: e3df51c00898556b10dcb6f2e96ca501b0455ec2
[2024-02-08 06:26:47:283 INFO] Configuration: Publish
[2024-02-08 06:26:47:286 INFO] Level Name: Bedrock level
[2024-02-08 06:26:47:288 INFO] No CDN config file found for dedicated server
[2024-02-08 06:26:47:289 INFO] Game mode: 0 Survival
[2024-02-08 06:26:47:289 INFO] Difficulty: 1 EASY
[2024-02-08 06:26:47:293 INFO] Content logging to console is enabled.
[2024-02-08 06:26:47:751 INFO] Opening level 'worlds/Bedrock level/db'
[2024-02-08 06:26:50:888 INFO] IPv4 supported, port: 19132: Used for gameplay and LAN discovery
[2024-02-08 06:26:50:888 INFO] IPv6 not supported
[2024-02-08 06:26:50:933 INFO] Server started.
[2024-02-08 06:26:50:934 INFO] ================ TELEMETRY MESSAGE ===================
[2024-02-08 06:26:50:934 INFO] Server Telemetry is currently not enabled. 
[2024-02-08 06:26:50:934 INFO] Enabling this telemetry helps us improve the game.
[2024-02-08 06:26:50:934 INFO] 
[2024-02-08 06:26:50:934 INFO] To enable this feature, add the line 'emit-server-telemetry=true'
[2024-02-08 06:26:50:934 INFO] to the server.properties file in the handheld/src-server directory
[2024-02-08 06:26:50:935 INFO] ======================================================
```

## Configuration

### Configuration on server startup

Some configuration needs to be passed as an ENV when server is being created - for instance seed or difficulty level.

In order to change those, update the ConfigMap in `kubernetes.yml` file and start/restart the server.

### Configuration on running server

Other things can only be configured on a running server - for instance showing coordinates.

Those can be changed using Minecraft Bedrock commands -> [https://minecraftbedrock-archive.fandom.com/wiki/Commands/List_of_Commands](https://minecraftbedrock-archive.fandom.com/wiki/Commands/List_of_Commands).

In order to run command on a server use `make bash` + `send-command`:

```sh
$ make bash
root@bds-0:/data# send-command gamerule showCoordinates true
root@bds-0:/data# 
```

You can also add some commands you often run on new server to `Makefile` and apply them with `make config`.

Pro-tip - run `make logs` in one terminal tab and commands in another, to see if they are being processed correctly. 

## Backup

On first start a `~/minecraft-data` folder will be created (if not existing). 

It can be backed up by copying to another path/drive.

To restore the backup restore those files and restat the server.

## Connection

Server listens on TCP/UDP port `19132`.

### LAN

Server runs in a local network (LAN).

Local IP can be used to connect to the server by clients in the same network.

To find out your local IP check `System Settings -> Network -> pick active network -> Details -> IP address`.

### Internet

To access from the Internet (outside of LAN) redirect port `19132 TCP/UDP` on your router to a server local IP.

Use your network public IP (google: "what is my ip") to connect or configure a Dynamic DNS service.

## Cron

The following scripts can be run via CRON:

```
crontab -e

0 5 * * * /Users/robert/projects/minecraft-bedrock-server-kubernetes/backup.sh >> /Users/robert/projects/minecraft-bedrock-server-kubernetes/backup.log 2>&1
0 6 * * * /Users/robert/projects/minecraft-bedrock-server-kubernetes/restart.sh >> /Users/robert/projects/minecraft-bedrock-server-kubernetes/restart.log 2>&1
```

Each day at 5 AM the server will be backed up and at 6 AM it will be restarted.

Logs will be saved in `backup.log` and `restart.log` files.
