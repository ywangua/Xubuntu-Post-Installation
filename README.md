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
* When editing the `grub` file, remove "quiet splash" in GRUB_CMDLINE_LINUX_DEFAULT so that `GRUB_CMDLINE_LINUX_DEFAULT=""`. Save and exit, and then update grub.
```
sudo update-grub
sudo reboot
```
If rebooting successfully, we will continue to install other software/programs

## Install google chrome
```
cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo nala install -y ./google-chrome-stable_current_amd64.deb 
```
Change the default browser to Google Chrome in `Default Applications`.

## Install common apps from repository
```
sudo nala install -y gimp inkscape blender xournalpp evince cheese conky-all goldendict 7zip 7zip-rar flameshot ttf-mscorefonts-installer net-tools htop okular pdfarranger lyx texlive-full ibus-rime vim rclone wine winetricks obs-studio python-is-python3 pymol
```
I did not include python packages (including Jupyter lab/notebook) here, as it depends on the project and need. They can be installed later

## Install other apps
```
wget https://github.com/rustdesk/rustdesk/releases/download/1.3.2/rustdesk-1.3.2-x86_64.deb
sudo nala install -y ./rustdesk-1.3.2-x86_64.deb
wget https://vscode.download.prss.microsoft.com/dbazure/download/stable/65edc4939843c90c34d61f4ce11704f09d3e5cb6/code_1.95.1-1730355339_amd64.deb
sudo nala install -y ./code_1.95.1-1730355339_amd64.deb
wget https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb
sudo nala install -y ./onlyoffice-desktopeditors_amd64.deb
wget https://cdn.zoom.us/prod/6.2.6.2503/zoom_amd64.deb
sudo nala install -y ./zoom_amd64.deb
wget https://github.com/IsmaelMartinez/teams-for-linux/releases/download/v1.11.3/teams-for-linux_1.11.3_amd64.deb
sudo nala install -y ./teams-for-linux_1.11.3_amd64.deb
```

## Install Zotero
```
wget https://download.zotero.org/client/release/7.0.9/Zotero-7.0.9_linux-x86_64.tar.bz2
tar -xvjf Zotero-7.0.9_linux-x86_64.tar.bz2
mkdir ~/bin
mv Zotero_linux-x86_64 ~/bin/zotero
cd ~/bin/zotero
./set_launcher_icon 
ln -s /home/$USER/bin/zotero/zotero.desktop /home/$USER/.local/share/applications/zotero.desktop
```
At this point, start zotero, close it. Then copy and replace your profile files to ~/.zotero/zotero/ to allow easy sync.

## Install Fiji
```
wget https://downloads.imagej.net/fiji/latest/fiji-linux64.zip
unzip fiji-linux64.zip -d ~/bin/
cd ~/bin/Fiji.app
ln -s /home/$USER/bin/Fiji.app/ImageJ-linux64 ~/bin/fiji
ln -s /home/$USER/bin/Fiji.app/ImageJ-linux64 ~/bin/imagej
ln -s /home/$USER/bin/Fiji.app/ImageJ-linux64 ~/bin/ImageJ
```

## Install VMD
Go to `https://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=VMD` and download VMD


## Set up rclone
```
mkdir ~/Box
rclone config
```
At this step, set up for box following instructions. Then, we will create shell script to allow easy mounting/unmounting of the Box Drive.
```
echo "rclone mount box:/ ~/Box --vfs-cache-mode full --transfers 10 --daemon" > ~/bin/boxmount
chmod +x ~/bin/boxmount
echo "fusermount -u ~/Box" > ~/bin/boxunmount
chmod +x ~/bin/boxunmount
boxmount
```

## Set up rustdesk
Open rustdesk and set up passwords, etc.

## Set up autostart programs
Create `xxx.desktop` in the `~/.config/autostart/` folder

## Dictionary for GoldenDict
```
mkdir ~/.goldendict
```
Then copy 

## Set up pinyin input method
* Add Chinese in `Language Support`
* Add `Chinese - Rime` for Input Methods in `Ibus Preferences`
* In the file `~/.config/ibus/rime/build/luna_pinyin.schema.yaml`, add `reset: 1` to `simplification`
```
switches:
  - name: ascii_mode
    reset: 0
    states: ["中文", "西文"]
  - name: full_shape
    states: ["半角", "全角"]
  - name: simplification
    reset: 1
    states: ["漢字", "汉字"]
  - name: ascii_punct
    states: ["。，", "．，"]
```
