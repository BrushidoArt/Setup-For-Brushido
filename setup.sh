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

# Install inotify-tools
sudo apt-get update
sudo apt-get install inotify-tools -y

# Set NTP synchronization and timezone
sudo timedatectl set-ntp yes
sudo timedatectl set-timezone America/Chicago

# Prompt user to change their password
echo "Please enter a new password:"
passwd

# Install necessary packages
sudo apt install wget git python3 python3-venv libgl1 libglib2.0-0 -y
wait

# Navigate to Desktop directory and create a new directory
cd ~/Desktop/
mkdir -p stablea1111
cd ~/Desktop/stablea1111/


# Download the webui script from the GitHub repository
wget -q https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh -O webui.sh
wait

# Modify permissions to make the script executable
sudo chmod +x webui.sh

# Execute the script
echo "Starting the webui script. Once it is done initializing and has become idle, press Ctrl+C to stop it."
./webui.sh

# The script blocks here until you manually stop webui.sh with Ctrl+C
# Prompt user to continue
read -p "Press ENTER once you have killed the script to continue..."

# Navigate to Desktop directory and create a new directory
cd ~/Desktop/stablea1111/stable-diffusion-webui

# Modify the line in webui-user.sh to include --xformers --no-half-vae
sed -i 's/^#export COMMANDLINE_ARGS=""/export COMMANDLINE_ARGS="--xformers --no-half-vae"/' webui-user.sh

# Download the ui-config.json script from the GitHub repository
wget -q  https://raw.githubusercontent.com/BrushidoArt/Setup-For-Brushido/master/ui-config.json -O ~/Desktop/stablea1111/stable-diffusion-webui/ui-config.json
wait

# Download the ui-config.json script from the GitHub repository
wget -q  https://raw.githubusercontent.com/BrushidoArt/Setup-For-Brushido/master/config.json -O ~/Desktop/stablea1111/stable-diffusion-webui/config.json
wait

# Download monitor.sh and filecopy.sh to Desktop ---
cd ~/Desktop
wget -q "https://raw.githubusercontent.com/BrushidoArt/Setup-For-Brushido/master/monitor.sh" \
     -O ~/Desktop/monitor.sh
wait

wget -q "https://raw.githubusercontent.com/BrushidoArt/Setup-For-Brushido/master/filecopy.sh" \
     -O ~/Desktop/filecopy.sh
wait
# Make them executable
chmod +x ~/Desktop/monitor.sh
chmod +x ~/Desktop/filecopy.sh

# Launch Firefox with the specified URLs
firefox \
  "https://openmodeldb.info/models/4x-Remacri" \
  "https://civitai.com/models/835655/illustrious-xl-personal-merge-noob-v-pred05-test-merge-updated" \
  "https://civitai.com/models/503815/nova-furry-xl?modelVersionId=1164762" \
  "https://github.com/Coyote-A/ultimate-upscale-for-automatic1111" \
  "http://127.0.0.1:7860/?__theme=dark" \
  "https://civitai.com/models/296576/sdxl-vae"

# Final user interaction prompt
echo "Please follow any additional on-screen instructions to proceed. Be sure to run the upscaler at least once to create the ESRGAN directory and download the items from Civitai and or the extensions section in the webui"
