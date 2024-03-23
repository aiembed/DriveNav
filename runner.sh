#!/bin/bash

# Function to install jq if not already installed
install_jq() {
    if ! command -v jq &> /dev/null; then
        echo "jq is not installed. Installing..."
        sudo apt-get update
        sudo apt-get install -y jq
        echo "jq installed successfully."
    fi
}

# Set execute permission for the script
chmod +x "$0"

# Install jq
install_jq

# Define variables
OWNER="aiembed"
REPO="DriveNav"
SCRIPT_NAME="start.py"
SERVICE_NAME="myscript.service"
SERVICE_CONTENT="[Unit]\nDescription=My Script Service\nAfter=multi-user.target\n\n[Service]\nType=idle\nExecStart=/usr/bin/python3 /home/pi/DriveNav/$SCRIPT_NAME\n\n[Install]\nWantedBy=multi-user.target"

# Get the latest release information using GitHub API
LATEST_RELEASE_URL="https://api.github.com/repos/$OWNER/$REPO/releases/latest"
LATEST_RELEASE=$(curl -s "$LATEST_RELEASE_URL" | jq -r '.tag_name')

# Construct the download URL for the Python script
SCRIPT_URL="https://raw.githubusercontent.com/$OWNER/$REPO/$LATEST_RELEASE/myscript.py"

# Change to the desired directory
cd ~/DriveNav || exit

# Check if the Python script exists
if [ -f "$SCRIPT_NAME" ]; then
    echo "Python script '$SCRIPT_NAME' found."
else
    echo "Downloading Python script '$SCRIPT_NAME' from $SCRIPT_URL..."
    wget "$SCRIPT_URL"
    if [ $? -eq 0 ]; then
        echo "Python script '$SCRIPT_NAME' downloaded successfully."
    else
        echo "Failed to download Python script. Exiting."
        exit 1
    fi
fi

# Set execute permission for the script
chmod +x "$SCRIPT_NAME"

# Create the systemd service file
echo -e "$SERVICE_CONTENT" | sudo tee "/etc/systemd/system/$SERVICE_NAME" > /dev/null

# Reload systemd
sudo systemctl daemon-reload

# Enable the service
sudo systemctl enable "$SERVICE_NAME"

# Start the service
sudo systemctl start "$SERVICE_NAME"

echo "Setup completed."
