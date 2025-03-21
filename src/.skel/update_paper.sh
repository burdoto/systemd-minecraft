#!/bin/bash

# Define the file that will store the latest Minecraft version
VERSION_FILE="minecraft.version"

# Check if the version file exists
if [[ -f "$VERSION_FILE" ]]; then
  # Read the version from the file
  LATEST_VERSION=$(cat "$VERSION_FILE")
  echo "Read latest Minecraft version from file: $LATEST_VERSION"
else
  # Fetch the latest Minecraft version from the PaperMC API
  LATEST_VERSION=$(curl -s https://api.papermc.io/v2/projects/paper | jq -r '.versions[-1]')

  # Check if the latest version was fetched correctly
  if [[ -z "$LATEST_VERSION" ]]; then
    echo "Failed to fetch the latest Minecraft version. Exiting."
    exit 1
  fi

  # Save the latest version to the file
  #echo "$LATEST_VERSION" > "$VERSION_FILE"
  #echo "Fetched and saved latest Minecraft version: $LATEST_VERSION"
fi

# Output the latest version
echo "Latest Minecraft version: $LATEST_VERSION"

# Fetch the latest build number for the latest version
LATEST_BUILD=$(curl -s https://api.papermc.io/v2/projects/paper/versions/$LATEST_VERSION | jq -r '.builds[-1]')

# Check if the latest build number was fetched correctly
if [[ -z "$LATEST_BUILD" ]]; then
  echo "Failed to fetch the latest build number for version $LATEST_VERSION. Exiting."
  exit 1
fi

echo "Latest PaperMC build for Minecraft version $LATEST_VERSION: $LATEST_BUILD"

# Construct the download URL for the latest PaperMC jar
DOWNLOAD_URL="https://api.papermc.io/v2/projects/paper/versions/$LATEST_VERSION/builds/$LATEST_BUILD/downloads/paper-$LATEST_VERSION-$LATEST_BUILD.jar"

# Download the latest PaperMC jar using wget
echo "Downloading PaperMC for Minecraft version $LATEST_VERSION, build $LATEST_BUILD..."
wget $DOWNLOAD_URL -q -O server.jar

# Verify if the download was successful
if [[ $? -eq 0 ]]; then
  echo "PaperMC version $LATEST_VERSION build $LATEST_BUILD downloaded successfully."
else
  echo "Failed to download PaperMC version $LATEST_VERSION build $LATEST_BUILD."
  exit 1
fi
