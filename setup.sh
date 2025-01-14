#!/bin/bash

# Update package lists
sudo apt update
wait

# Upgrade all installed packages
sudo apt upgrade -y
wait

# Install Discord
wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"
sudo apt install ./discord.deb -y
wait

# Set NTP synchronization and timezone
sudo timedatectl set-ntp yes
sudo timedatectl set-timezone America/Chicago

# Prompt user to change their password
echo "Please enter a new password:"
passwd

# Navigate to Desktop directory and create a new directory
cd /home/Ubuntu/Desktop/
mkdir -p stablea1111
cd stablea1111

# Install necessary packages
sudo apt install wget git python3 python3-venv libgl1 libglib2.0-0 -y
wait

# Download the webui script from the GitHub repository
wget -q https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh -O webui.sh
wait

# Download the ui-config.json script from the GitHub repository
wget -q  https://raw.githubusercontent.com/BrushidoArt/Setup-For-Brushido/master/ui-config.json -O ~/Desktop/stablea1111/stable-diffusion-webui/ui-config.json
wait

# Navigate into stable-diffusion-webui
cd ~/Desktop/stablea1111/stable-diffusion-webui/

# Modify the line in webui-user.sh to include --xformers --no-half-vae
sed -i 's/^#export COMMANDLINE_ARGS=""/export COMMANDLINE_ARGS="--xformers --no-half-vae"/' webui-user.sh

# Modify permissions to make the script executable
sudo chmod +x webui.sh

# Execute the script and wait for user input
./webui.sh

# Final user interaction prompt
echo "Please follow any additional on-screen instructions to proceed."
