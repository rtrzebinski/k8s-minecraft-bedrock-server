A MacOS wrapper for running [https://github.com/itzg/docker-minecraft-bedrock-server](https://github.com/itzg/docker-minecraft-bedrock-server) in a Kubernetes cluster.

Tested with `MacOS Sonoma 14.3` / `Docker Desktop Kubernetes`.

Usage:

```
$ make
target                         help
------                         ----
help                           Show this help
start                          Start server
stop                           Stop server
```

On start it will create a `~/minecraft-data` folder - it can be backed up by copying to another path/drive. To restore the backup restore these files and restat the server.
