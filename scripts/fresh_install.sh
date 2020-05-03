#! /bin/bash

#Script to install important applications for the development enviroment on a fresh install of Ubuntu and Debian based systems.

# ====================

#.deb files presence confirmation:
read -r -p "The following files need to be on the same folder as this script in order to install all applications and dependencies:

Chrome Dev - Rename do chrome-dev.deb
Visual Studio Code - Rename do code.deb
Hyper - Rename to hyper.deb
Discord - Rename to discord.deb

Do you wish to proceed? [y/N] " response
response=${response,,}    # tolower
if [[ "$response" =~ ^(yes|y)$ ]]
then

#Upgrades already existing system packages
printf "%s\n" "Upgrading system packages..."
sudo apt-get update && sudo apt-get upgrade -y
printf "%s\n" " "

#Install .deb files from the script folder
printf "%s\n" "Installing Chrome Dev..."
sudo dpkg -i chrome-dev.deb
printf "%s\n" " "

printf "%s\n" "Installing Visual Studio Code..."
sudo dpkg -i code.deb
xdg-mime default code.desktop text/plain
printf "%s\n" " "

printf "%s\n" "Installing Hyper.js..."
sudo dpkg -i hyper.deb
printf "%s\n" " "

printf "%s\n" "Installing Discord..."
sudo dpkg -i discord.deb
printf "%s\n" " "

# Removes unused crap
printf "%s\n" "Removing unused programs..."
sudo apt-get remove hexchat hexchat-common thunderbird thunderbird-gnome-support thunderbird-locale-en  thunderbird-locale-en-us  banshee tomboy pidgin pidgin-libnotify -y
printf "%s\n" " "

# Installs essential development tools
printf "%s\n" "Configuring the development enviroment..."
sudo apt install build-essential -y
sudo apt install curl -y
sudo apt install git ssh -y
sudo apt install zsh -y

# Configures git:
printf "%s\n" "Configuring git..." 
printf "%s\n" "Write your git username:" 
read USER
DEFAULT_EMAIL="$USER@users.noreply.github.com"
read -p "Write your git email [Press enter to accept the private email $DEFAULT_EMAIL]: " EMAIL
EMAIL="${EMAIL:-${DEFAULT_EMAIL}}"

printf "%s\n" "Configuring global user name and email..."
git config --global user.name "$USER"
git config --global user.email "$EMAIL"

printf "%s\n" "Configuring global aliases..."
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.sub "submodule update --remote --merge"
git config --global core.editor "vim"
git config --global credential.helper 'cache --timeout=36000'

printf "%s\n" "Adding git credentials..."
printf "%s\n" "Configuring git ssh access..."
ssh-keygen -t rsa -b 4096 -C "$EMAIL"
printf "%s\n" "This is your public key. To activate it in github, go to settings, SHH and GPG keys, New SSH key, and enter the following key:"
cat ~/.ssh/id_rsa.pub

#Installs missing dependencies, double checks updates and removes cache files:
printf "%s\n" "Finishing and cleaning up..."
sudo apt install -f
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get autoclean -y
sudo apt-get autoremove -y 

else
  exit 0
fi
