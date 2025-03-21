#!/bin/bash

# install run dependencies
pacman -Sy tar  rgx-git mcrcon || exit 1

# copy base scripts
cp -r src/* /opt/mc

# create backups dir, if it doesnt exist
if [ ! -d "/backup" ]; then
    echo "Backup directory '/backup' missing, creating..."
    mkdir /backup
fi

# copy systemd unit file
cp "mc@.service" /etc/systemd/system
systemctl daemon-reload
