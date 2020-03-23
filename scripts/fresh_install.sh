#! /bin/bash

#Script to install important applications on a fresh install of Ubuntu and Debian based systems.

#The following files are required in the same folder of the script for the installation to work:
#hyper.deb
#code.deb
#discord.deb
#chrome.deb
#opera.deb

#Get the .deb files from their respective websites and rename then to make sure all software will be installed.

# ====================
# Color definitions

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
WHITE="\033[37m"
NORMAL="\033[0;39m"

# ====================

###Checking for the .deb files
read -r -p "This script will install some programs using .deb files, and they should be in the same folder you're running the script from. Do you wish to proceed? [y/n] " RESP
RESP=${RESP,,}    # tolower (only works with /bin/bash)
if [[ $RESP =~ ^(yes|y)$ ]]
then

#######
#Update & Upgrade
echo
echo "Updating and Upgrading"
echo
sudo apt-get update && sudo apt-get upgrade -y

#Remove unused programs
echo
echo "Removing unused programs..."
echo
sudo apt-get remove hexchat hexchat-common thunderbird thunderbird-gnome-support thunderbird-locale-en  thunderbird-locale-en-us  banshee tomboy pidgin pidgin-libnotify -y
printf "\n${GREEN}System sucessfully updated!${NORMAL}\n"

#Installing development setup
echo
printf "\n${YELLOW}Starting the installation of the development setup...${NORMAL}\n"
echo
###########
echo "Installing build-essentials..."
sudo apt install build-essential -y
echo

echo "Installing curl..."
sudo apt install curl -y
echo

echo "Installing git and ssh..."
sudo apt install git ssh -y
echo

echo
sudo apt install zsh
echo

echo "Installing Hyper..."
sudo dpkg -i hyper.deb
echo

echo "Installing Visual Studio Code and dependencies..."
sudo dpkg -i code.deb
sudo apt-get install -f
xdg-mime default code.desktop text/plain
echo
printf "\n${GREEN}Development enviroment sucessfully instaled!${NORMAL}\n"

#Installing utility programs
printf "\n${GREEN}Starting the installation of utility programs...${NORMAL}\n"
echo

echo "Installing VLC..."
sudo apt install vlc -y
echo

echo "Installing Discord..."
sudo dpkg -i discord.deb
echo

echo "Installing Mailspring..."
sudo snap install mailspring
echo

echo "Installing Google Chrome..."
sudo dpkg chrome.deb
echo

echo "Installing Opera"
sudo dpkg opera.deb
echo

printf "\n${GREEN}Utility programs sucessfully installed!${NORMAL}\n"

#Cleaning up and finishing
printf "\n${YELLOW}Cleaning up the cache and finishing...${NORMAL}\n"
sudo apt install -f
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get autoclean -y
sudo apt-get autoremove -y 
echo

printf "\n${GREEN}All done! Make sure to execute the git_configure.sh to sync your Git to Github.${NORMAL}\n"

fi
