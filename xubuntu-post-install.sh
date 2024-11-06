#!/bin/bash
#
# Author: Yong Wang (yongwang@uark.edu)
# Description: a post-installation bash script for Xubuntu, tailored for research laptop (Dell) used in our laboratory
#
# This script is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3.
# This script is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program; if not, see <https://www.gnu.org/licenses/gpl-3.0.txt>

function upgrade_system()
{
    clear
    echo "**************************************************"
    echo "                Upgrading System                  "
    echo "**************************************************"
    sudo nala update
    sudo nala upgrade -y
}

function install_common_apps()
{
    clear
    echo "**************************************************"
    echo "       Installing Common Applications             "
    echo "**************************************************"
    echo ""
    # Apps that can be installed from apt repositories
    sudo nala install -y gimp inkscape blender cheese flameshot obs-studio vlc
    sudo nala install -y xournalpp evince okular pdfarranger goldendict
    sudo nala install -y 7zip 7zip-rar
    sudo nala install -y net-tools htop conky-all git
    sudo nala install -y ttf-mscorefonts-installer lyx texlive-full
    sudo nala install -y ibus-rime
    sudo nala install -y vim
    sudo nala install -y python-is-python3 python3-pip python3-virtualenv pymol
    sudo nala install -y wine winetricks
    sudo nala install -y rclone
    # Others apps
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
}

function fix_dell_webcam()
{
    clear
    echo "**************************************************"
    echo "                Fixing Webcam                     "
    echo "**************************************************"
    uname -r
    sudo nala install -y linux-modules-ipu6-6.8.0-48-generic linux-modules-ivsc-generic
    sudo add-apt-repository ppa:oem-solutions-group/intel-ipu6
    sudo nala update
    sudo nala install -y libcamhal-ipu6ep0
    sudo add-apt-repository -r ppa:oem-solutions-group/intel-ipu6    
    echo ""
    echo "Remove 'quiet splash' for the line of GRUB_CMDLINE_LINUX_DEFAULT=   of the grub file"
    read -p "Press <Enter> to Continue ..."
    sudo nano /etc/default/grub
    sudo update-grub
}

function set_up_box_drive()
{
    clear
    echo "**************************************************"
    echo "              Setting Up Box Drive                "
    echo "**************************************************"
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
}

function install_python_packages()
{
    clear
    echo "**************************************************"
    echo "            Installing Python and Packages        "
    echo "**************************************************"
    mkdir ~/.virtualenvs
    virtualenv ~/.virtualenvs/base
    source ~/.virtualenvs/base/bin/activate
    pip install numpy scipy matplotlib
    pip install pandas
    pip install jupyterlab
}

function show_other_info()
{
cat > file.tmp <<'_EOF_'
Other Information:

* Zotero: for easy sync, copy and paste your profile files to ~/.zotero/zotero/ mannually.

* VMD: download VMD from https://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=VMD, and install it following the Installation Guide at https://www.ks.uiuc.edu/Research/vmd/current/ig/ig.html

* GoldenDict: dictionaries should be placed in ~/.goldendict

* Startup Apps: create xxx.desktop in the ~/.config/autostart/ folder

* Chinese Input: 
    (1) add Chinese in Language Support, 
    (2) add Chinese - Rime for Input Methods in Ibus Preferences, 
    (3) add 'reset: 1' to simplification in ~/.config/ibus/rime/build/luna_pinyin.schema.yaml


_EOF_
    clear
    cat file.tmp
    rm file.tmp
    read -p "Press <Enter> to Continue ..."
}

clear
echo "**************************************************"
echo "*        Post-Install Script for Xubuntu         *"
echo "*               Author: Yong Wang                *"
echo "**************************************************"
echo ""
echo ""
echo "**** Updating APT repositories ... ****"
echo ""
echo ""
sudo apt update
sudo apt install -y nala
sudo nala update
sudo nala install -y dialog
clear

choices=$(dialog \
    --backtitle "Post-Install Options" \
    --title "" \
    --separate-output \
    --checklist "Select options to install:" 14 60 10 \
    "1" "Upgrading system" on \
    "2" "Install commonly used apps" on \
    "3" "Fix Dell webcam" off \
    "4" "Set up Box Drive" off \
    "5" "Install Python Packages" on \
    "6" "Show other info" off \
    2>&1 >/dev/tty)
clear

for choice in $choices
do
    case $choice in
    1) upgrade_system ;;
    2) install_common_apps ;;
    3) fix_dell_webcam ;;
    4) set_up_box_drive ;;
    5) install_python_packages ;;
    6) show_other_info ;;
    esac
done

clear
echo "**************************************************"
echo "*        Post-Install Script for Xubuntu         *"
echo "*               Author: Yong Wang                *"
echo "**************************************************"
echo ""
echo ""
read -p "Post-Installation is DONE! Press <Enter> to Continue ..."
clear


