### Info

MacOS wrapper for running [https://github.com/itzg/docker-minecraft-bedrock-server](https://github.com/itzg/docker-minecraft-bedrock-server) in a local Kubernetes cluster.

Requires Docker Desktop with Kubernetes enabled.

### Usage

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

### Backup

On start it will create a `~/minecraft-data` folder - it can be backed up by copying to another path/drive. To restore the backup restore those files and restat the server.

### Connection

Server runs in a local network (LAN). Local IP will be displayed on server start - this ip can be used to connect to the server by clients withing the same network.

To access from the Intenret (outside of LAN) redirect port `19132 TCP/UDP` on your router to a server local IP.
