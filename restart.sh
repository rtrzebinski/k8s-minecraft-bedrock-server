#!/bin/bash
/usr/local/bin/kubectx docker-desktop
cd /Users/robert/projects/minecraft-bedrock-server-kubernetes
/usr/bin/make restart
echo "completed" `date`
