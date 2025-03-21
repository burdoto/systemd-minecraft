#!/usr/bin/bash

echo "Starting Minecraft Server $1"
cd "/opt/mc/$1"

# Prepare server composition
rm -rf mods
find plugins -type f -name '*.jar' -delete

cp -rf .side/common/* .
cp -rf .side/server/* .

# Check if update.sh exists, and if it does, execute it
if [ -f "update.sh" ]; then
    echo "Running update script for $1"
    bash "update.sh"
else
    echo "No update script found for $1"
fi

# Set up stdin and start the server
rm -f "stdin"
echo "save-on" > "stdin"
chmod 770 "stdin"

if [ -f "launch.sh" ]; then
    echo "Using custom launch.sh script..."
    tail -f stdin | bash launch.sh
else
    echo "Using server.jar to natively start server..."
    tail -f stdin | java @user_args.txt @memory.txt -jar server.jar nogui
fi
