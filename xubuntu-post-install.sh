#!/bin/bash
#
# Author: Yong Wang (yongwang@uark.edu)
# Description: a post-installation bash script for Xubuntu, tailored for research laptop (Dell) used in our laboratory
#
# This script is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3.
# This script is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program; if not, see <https://www.gnu.org/licenses/gpl-3.0.txt>

clear
echo "**************************************************"
echo "*        Post-Install Script for Xubuntu         *"
echo "**************************************************"

echo ""
echo "==== Update System and Install nala ===="
read -p "Press <Enter> to Continue ..."
sudo apt update
sudo apt install -y nala
sudo nala update
sudo nala upgrade -y

echo ""
echo "==== Install Common Apps from Repository ===="
read -p "Press <Enter> to Continue ..."
sudo nala install -y gimp inkscape blender xournalpp evince cheese conky-all goldendict 7zip 7zip-rar flameshot ttf-mscorefonts-installer net-tools htop okular pdfarranger lyx texlive-full ibus-rime vim rclone wine winetricks obs-studio python-is-python3 pymol git

echo ""
echo "==== Install Other Apps ===="
read -p "Press <Enter> to Continue ..."
cd ~/Downloads
# Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo nala install -y ./google-chrome-stable_current_amd64.deb
# RustDesk
wget https://github.com/rustdesk/rustdesk/releases/download/1.3.2/rustdesk-1.3.2-x86_64.deb
sudo nala install -y ./rustdesk-1.3.2-x86_64.deb
# VS Code
wget https://vscode.download.prss.microsoft.com/dbazure/download/stable/65edc4939843c90c34d61f4ce11704f09d3e5cb6/code_1.95.1-1730355339_amd64.deb
sudo nala install -y ./code_1.95.1-1730355339_amd64.deb
# OnlyOffice
wget https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb
sudo nala install -y ./onlyoffice-desktopeditors_amd64.deb
# Zoom
wget https://cdn.zoom.us/prod/6.2.6.2503/zoom_amd64.deb
sudo nala install -y ./zoom_amd64.deb
# Teams
wget https://github.com/IsmaelMartinez/teams-for-linux/releases/download/v1.11.3/teams-for-linux_1.11.3_amd64.deb
sudo nala install -y ./teams-for-linux_1.11.3_amd64.deb
# Fiji ImageJ
wget https://downloads.imagej.net/fiji/latest/fiji-linux64.zip
unzip fiji-linux64.zip -d ~/bin/
cd ~/bin/Fiji.app
ln -s /home/$USER/bin/Fiji.app/ImageJ-linux64 ~/bin/fiji
ln -s /home/$USER/bin/Fiji.app/ImageJ-linux64 ~/bin/imagej
ln -s /home/$USER/bin/Fiji.app/ImageJ-linux64 ~/bin/ImageJ
# Zotero
wget https://download.zotero.org/client/release/7.0.9/Zotero-7.0.9_linux-x86_64.tar.bz2
tar -xvjf Zotero-7.0.9_linux-x86_64.tar.bz2
mkdir ~/bin
mv Zotero_linux-x86_64 ~/bin/zotero
cd ~/bin/zotero
./set_launcher_icon 
ln -s /home/$USER/bin/zotero/zotero.desktop /home/$USER/.local/share/applications/zotero.desktop
mkdir ~/.zotero/zotero
echo ""
echo "For easy sync, you can copy and paste your profile files to ~/.zotero/zotero/ mannually."
read -p "When you are ready for the next step, Press <Enter> to Continue ..."
# VMD
echo "Go to https://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=VMD, download VMD, and install it following the Installation Guide at https://www.ks.uiuc.edu/Research/vmd/current/ig/ig.html"
read -p "When you are ready for the next step, Press <Enter> to Continue ..."

echo ""
echo "==== Set up Rclone and Box Drive ===="
echo "Refer to https://rclone.org/box/ for details"
read -p "Press <Enter> to Continue ..."
cd
mkdir ~/Box
rclone config
echo "rclone mount box:/ ~/Box --vfs-cache-mode full --transfers 10 --daemon" > ~/bin/boxmount
chmod +x ~/bin/boxmount
echo "fusermount -u ~/Box" > ~/bin/boxunmount
chmod +x ~/bin/boxunmount
boxmount
