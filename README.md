# Setup.sh

**About**

The purpose of this file is to automate the install process of the following:

1. Installation of OS Repos/Updates
2. Installation of Automatic1111
3. Setting the timezone to CST (adjust as needed)
4. Installation of Discord
5. Updating the users password


**Pre-Reqs**

You will need an instance running wget.
1. Open a terminal
2. Install wget
    - ```bash
      sudo apt install wget -y
      ```

**Pull The File To Your Desktop**

Once you've installed wget you will need to pull down the file from github to the desktop,

1. cd to the Desktop
    - ```bash
      cd /home/$USER/Desktop/
      ```
2. Pull down the script from github, append the permissions, and run the file
    - ```bash
      wget -O ~/Desktop/setup.sh https://raw.githubusercontent.com/BrushidoArt/Setup-For-Brushido/main/setup.sh && chmod +x setup.sh && ./setup.sh
      ```
