#!/bin/bash

# Update package lists
sudo apt update
wait

# Upgrade all installed packages
sudo apt upgrade -y
wait

# Install FileZilla and run it
sudo apt install filezilla -y
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

# Modify permissions to make the script executable
sudo chmod +x webui.sh

# Run Filezilla
filezilla &

# Execute the script and wait for user input
./webui.sh

# Final user interaction prompt
echo "Please follow any additional on-screen instructions to proceed."
