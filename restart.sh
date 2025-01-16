#!/bin/bash

alias make='/usr/bin/make'
alias kubectl='/usr/local/bin/kubectl'
alias kubectx='/usr/local/bin/kubectx'

kubectx docker-desktop

cd /Users/robert/projects/minecraft-bedrock-server-kubernetes

make restart

kubectl wait --for=condition=Ready pod/bds-0 -n minecraft-server --timeout=60s

make config

echo "completed" `date`
