MacOS wrapper for running [https://github.com/itzg/docker-minecraft-bedrock-server](https://github.com/itzg/docker-minecraft-bedrock-server) in a local Kubernetes cluster.

Requires Docker Desktop with Kubernetes enabled.

Usage:

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

On start it will create a `~/minecraft-data` folder - it can be backed up by copying to another path/drive. To restore the backup restore those files and restat the server.
