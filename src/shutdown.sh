#!/bin/bash

cd "/opt/mc/$1"

echo 'save-all'>stdin
echo 'tellraw @a ["",{"text":"[Server] ","color":"light_purple"},"Shutdown in ",{"text":"30","color":"aqua"}," seconds"]'>stdin
sleep 10
echo 'tellraw @a ["",{"text":"[Server] ","color":"light_purple"},"Shutdown in ",{"text":"20","color":"aqua"}," seconds"]'>stdin
sleep 10
echo 'save-all'>stdin
echo 'tellraw @a ["",{"text":"[Server] ","color":"light_purple"},"Shutdown in ",{"text":"10","color":"aqua"}," seconds"]'>stdin
sleep 5
echo 'tellraw @a ["",{"text":"[Server] ","color":"light_purple"},"Shutdown in ",{"text":"5","color":"aqua"}," seconds"]'>stdin
sleep 1
echo 'tellraw @a ["",{"text":"[Server] ","color":"light_purple"},"Shutdown in ",{"text":"4","color":"aqua"}," seconds"]'>stdin
sleep 1
echo 'tellraw @a ["",{"text":"[Server] ","color":"light_purple"},"Shutdown in ",{"text":"3","color":"aqua"}," seconds"]'>stdin
sleep 1
echo 'tellraw @a ["",{"text":"[Server] ","color":"light_purple"},"Shutdown in ",{"text":"2","color":"aqua"}," seconds"]'>stdin
sleep 1
echo 'tellraw @a ["",{"text":"[Server] ","color":"light_purple"},"Shutdown in ",{"text":"1","color":"aqua"}," second"]'>stdin
sleep 1

echo "stop">stdin
sleep 20 # give server time to actually shut down
