#!/bin/bash

if [ -z "$1" || -z "$2" ]; then
    echo "Usage: 'backup.sh <instance> <include...>'"

cd "/opt/mc/$1"

echo "Save World $2 and disable autosave to prevent corruption"
echo "save-all">stdin
echo "save-off">stdin

echo "Starting Backup"
(
    now=$(date '+%Y_%m_%d_%H_%M')
    it="/backup/$1/$now"
    mkdir -p "/backup/$1"
    echo "Compressing backup as $it.tar.gz"
    tar -zcvf "$it.tar.gz" logs/latest.log "${@:2}" || (echo "Backup failed" & exit)
) && echo "Backup completed"

echo "Re-enabling autosave"
echo "save-on">stdin
