#!/bin/bash

mkdir -p /Volumes/T7\ Shield/minecraft_backup
cp -R ~/minecraft-data/worlds /Volumes/T7\ Shield/minecraft_backup/$(date +'%Y-%m-%d_%H-%M-%S') && date >~/cron.log 2>~/cron.log
