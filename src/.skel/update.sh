#!/bin/bash

updateFromModrinth() {
  export data=$(curl -s "https://api.modrinth.com/v2/project/$1/version" | jq '.[] | select(.loaders | index("bukkit") or index("spigot") or index("paper"))' | jq -sr '.[0].files[0]')
  export file="plugins/$1.jar"
  export rhash=$(echo "$data" | jq -r '.hashes.sha1')
  export lhash=$(sha1sum -b "$file" | awk '{print $1}')
  export url=$(echo "$data" | jq -r '.url')
  echo -n "Downloading $1 from url $url... "
  if [[ "$lhash" == "$rhash" ]]; then
    echo "UP-TO-DATE"
  else
    (wget "$url" -q -O "$file" && echo "OK") || echo "FAIL"
  fi
}

updateFromSpigot() {
  export name=$(curl -s "https://api.spiget.org/v2/resources/$1" | jq -r .name | sed 's/[^a-zA-Z0-9]//g' | tr '[:upper:]' '[:lower:]')
  echo -n "Downloading $name from Spiget API... "
  (wget "https://api.spiget.org/v2/resources/$1/download" -q -O "plugins/$name.jar" && echo "OK") || echo "FAIL"
}

#./update_paper.sh

#updateFromModrinth chestshop
#updateFromModrinth chestsort
#updateFromModrinth coreprotect
#updateFromModrinth fancyholograms
#updateFromModrinth fancynpcs
#updateFromModrinth geyser
#updateFromModrinth lagfixer
#updateFromModrinth luckperms
#updateFromModrinth maintenance
#updateFromModrinth multiverse-core
#updateFromModrinth multiverse-inventories
#updateFromModrinth multiverse-netherportals
#updateFromModrinth multiverse-portals
#updateFromModrinth tab-was-taken
#updateFromModrinth viabackwards
#updateFromModrinth viaversion
#updateFromModrinth worldedit
#updateFromModrinth worldguard

#updateFromSpigot 2991 # AreaShop
#updateFromSpigot 36081 # BetterRTP
#updateFromSpigot 87610 # CMILib for JobsReborn
#updateFromSpigot 74429 # FCP
#updateFromSpigot 74208 # Graves
#updateFromSpigot 4216 # JobsReborn
#updateFromSpigot 69551 # LWC
#updateFromSpigot 34110 # MobArena
#updateFromSpigot 6245 # PlaceholderAPI
##updateFromSpigot 77506 # PlotSquared
#updateFromSpigot 88135 # PlugManX
#updateFromSpigot 114261 # Tebex
#updateFromSpigot 34315 # Vault
#updateFromSpigot 17311 # WESV
#updateFromSpigot 4823 # WGEF

#./update_modsuite.sh <-- do this manually for now
