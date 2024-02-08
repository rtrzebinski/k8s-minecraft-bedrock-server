## Info

MacOS wrapper for running [https://github.com/itzg/docker-minecraft-bedrock-server](https://github.com/itzg/docker-minecraft-bedrock-server) in a local Kubernetes cluster.

Requires Docker Desktop with Kubernetes enabled.

## Usage

Use make commands to interact with the server.

```
$ make
target                         help
------                         ----
help                           Show this help
start                          Start server
stop                           Stop server
restart                        Restart server
logs                           See server logs
```

### Start

```
$ make start
namespace/minecraft-server created
configmap/minecraft-bedrock created
statefulset.apps/bds created
service/bds created
==> Running on 192.168.0.103:19132
```

### Stop

```
$ make stop
namespace "minecraft-server" deleted
```

### Logs

```
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

## Backup

On start it will create a `~/minecraft-data` folder - it can be backed up by copying to another path/drive. To restore the backup restore those files and restat the server.

## Connection

Server runs in a local network (LAN). Local IP will be displayed on server start - this ip can be used to connect to the server by clients withing the same network.

To access from the Intenret (outside of LAN) redirect port `19132 TCP/UDP` on your router to a server local IP.
