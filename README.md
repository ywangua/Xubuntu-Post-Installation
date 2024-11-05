# Xubuntu-Post-Installation
Notes for installing useful software/programs for research after installing Xubuntu 24.04

## Update/upgrade and install nala
* Install nala
```
sudo apt update
sudo apt install -y nala
```
* Update and upgrade apps
```
sudo nala update
sudo nala upgrade
```

## Fix Dell laptop webcam
* Install driver and patch for the webcam
```
uname -r
sudo nala install linux-modules-ipu6-6.8.0-48-generic linux-modules-ivsc-generic
sudo add-apt-repository ppa:oem-solutions-group/intel-ipu6
sudo nala update
sudo nala install libcamhal-ipu6ep0
sudo add-apt-repository -r ppa:oem-solutions-group/intel-ipu6
```
* Sometimes the laptop may get stuck at the boot stage. However, the issue can be resolved by displaying the booting text (don't know why, but it works).
```
cd /etc/default/
sudo nano grub
```
* remove "quiet splash" in GRUB_CMDLINE_LINUX_DEFAULT so that `GRUB_CMDLINE_LINUX_DEFAULT=""`
```
sudo update-grub
sudo reboot
```

## Install google chrome
```
cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo nala install ./google-chrome-stable_current_amd64.deb 
```

## Install common apps from repository
```
sudo nala install gimp inkscape blender xournalpp evince cheese conky-all goldendict 7zip 7zip-rar flameshot ttf-mscorefonts-installer net-tools htop okular pdfarranger lyx texlive-full ibus-rime vim rclone wine winetricks obs-studio
```

## Install other apps
```
wget https://github.com/rustdesk/rustdesk/releases/download/1.3.2/rustdesk-1.3.2-x86_64.deb
sudo nala install ./rustdesk-1.3.2-x86_64.deb
wget https://vscode.download.prss.microsoft.com/dbazure/download/stable/65edc4939843c90c34d61f4ce11704f09d3e5cb6/code_1.95.1-1730355339_amd64.deb
sudo nala install ./code_1.95.1-1730355339_amd64.deb
wget https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb
sudo nala install ./onlyoffice-desktopeditors_amd64.deb
wget https://cdn.zoom.us/prod/6.2.6.2503/zoom_amd64.deb
sudo nala install ./zoom_amd64.deb
wget https://github.com/IsmaelMartinez/teams-for-linux/releases/download/v1.11.3/teams-for-linux_1.11.3_amd64.deb
sudo nala install ./teams-for-linux_1.11.3_amd64.deb
```

## Install Zotero
```
wget https://download.zotero.org/client/release/7.0.9/Zotero-7.0.9_linux-x86_64.tar.bz2
tar -xvjf Zotero-7.0.9_linux-x86_64.tar.bz2
mkdir ~/bin
mv Zotero_linux-x86_64 ~/bin/zotero
cd ~/bin/zotero
./set_launcher_icon 
ln -s /home/yongwang/bin/zotero/zotero.desktop /home/yongwang/.local/share/applications/zotero.desktop
# {start zotero and then replace the profile (~/.zotero/zotero/) for easy sync}
```
## Install Fiji
```
wget https://downloads.imagej.net/fiji/latest/fiji-linux64.zip
unzip fiji-linux64.zip -d ~/bin/
cd ~/bin/Fiji.app
ln -s /home/yongwang/bin/Fiji.app/ImageJ-linux64 ~/bin/fiji
ln -s /home/yongwang/bin/Fiji.app/ImageJ-linux64 ~/bin/imagej
ln -s /home/yongwang/bin/Fiji.app/ImageJ-linux64 ~/bin/ImageJ
```

## Set up rclone
```
mkdir ~/Box
rclone config
# set up for box following instructions
echo "rclone mount box:/ ~/Box --vfs-cache-mode full --transfers 10 --daemon" > ~/bin/boxmount
chmod +x ~/bin/boxmount
echo "fusermount -u ~/Box" > ~/bin/boxunmount
chmod +x ~/bin/boxunmount
boxmount
```
