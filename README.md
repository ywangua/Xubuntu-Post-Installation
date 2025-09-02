# Xubuntu Post-Installation Steps

## Installation of Xubuntu

Follow the GUI installer of Xubuntu and complete the installation.
Restart the computer and login.

## Install nala

Note that `nala` is much faster than `apt`. So we will have `nala`
installed first.

``` bash
sudo apt update
sudo apt install -y nala
```

## Install various third party (non-apt) apps

-   Google Chrome
-   VS Code
-   Zoom
-   Teams
-   Zotero
    -   For easy sync, you can copy and paste your profile files to `~/.zotero/zotero/` mannually
    -   Double check if `zotero.desktop` is in `~/.local/share/applications/`. If not, run `ln -s /home/$USER/bin/zotero/zotero.desktop /home/$USER/.local/share/applications/zotero.desktop` in terminal
-   RustDesk
-   FIJI ImageJ
-   CPDF
-   Quarto
-   uv
-   Rust
    -   It requires either `source` or `restart` of the terminal
-   Typst
    -   Make sure terminal is restarted before install Typst
``` bash
cd ~/Downloads

wget 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
sudo nala install -y ./google-chrome-stable_current_amd64.deb
rm ./google-chrome-stable_current_amd64.deb

wget 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64' -O ./code_latest_amd64.deb
sudo nala install -y ./code_latest_amd64.deb
rm ./code_latest_amd64.deb

wget 'https://zoom.us/client/latest/zoom_amd64.deb'
sudo nala install -y ./zoom_amd64.deb
rm ./zoom_amd64.deb

wget 'https://github.com/IsmaelMartinez/teams-for-linux/releases/download/v1.11.3/teams-for-linux_1.11.3_amd64.deb'
sudo nala install -y ./teams-for-linux_1.11.3_amd64.deb
sudo chmod 4755 /opt/teams-for-linux/chrome-sandbox
rm ./teams-for-linux_1.11.3_amd64.deb

wget 'https://download.zotero.org/client/release/7.0.9/Zotero-7.0.9_linux-x86_64.tar.bz2'
tar -xvjf Zotero-7.0.9_linux-x86_64.tar.bz2
mkdir ~/bin
mv Zotero_linux-x86_64 ~/bin/zotero
cd ~/bin/zotero
./set_launcher_icon 
ln -s /home/$USER/bin/zotero/zotero.desktop /home/$USER/.local/share/applications/zotero.desktop
mkdir -p ~/.zotero/zotero
cd ~/Downloads

wget 'https://github.com/rustdesk/rustdesk/releases/download/1.3.2/rustdesk-1.3.2-x86_64.deb'
sudo nala install -y ./rustdesk-1.3.2-x86_64.deb
rm ./rustdesk-1.3.2-x86_64.deb

wget 'https://downloads.imagej.net/fiji/latest/fiji-linux64.zip'
unzip fiji-linux64.zip -d ~/bin/
rm fiji-linux64.zip
cd ~/bin/Fiji.app
ln -s /home/$USER/bin/Fiji.app/ImageJ-linux64 ~/bin/fiji
ln -s /home/$USER/bin/Fiji.app/ImageJ-linux64 ~/bin/imagej
ln -s /home/$USER/bin/Fiji.app/ImageJ-linux64 ~/bin/ImageJ

cd ~/Downloads
wget 'https://github.com/coherentgraphics/cpdf-binaries/archive/master.zip'
unzip ./master.zip
cp ./cpdf-binaries-master/Linux-Intel-64bit/cpdf ~/bin/cpdf

wget 'https://github.com/quarto-dev/quarto-cli/releases/download/v1.7.32/quarto-1.7.32-linux-amd64.deb'
sudo nala install -y ./quarto-1.7.32-linux-amd64.deb
rm ./quarto-1.7.32-linux-amd64.deb

curl -LsSf https://astral.sh/uv/install.sh | sh

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
exit
```

After restarting terminal, install Typst

``` bash
cargo install --locked typst-cli
```

## Install Common Apps

We will use apt repositories to install common apps.

``` bash
sudo nala update
sudo nala install -y gimp inkscape blender cheese flameshot obs-studio vlc
sudo nala install -y xournalpp evince okular pdfarranger goldendict
sudo nala install -y 7zip 7zip-rar
sudo nala install -y net-tools htop conky-all git speedtest-cli
sudo nala install -y ttf-mscorefonts-installer lyx texlive-full
sudo nala install -y ibus-rime
sudo nala install -y vim neovim npm pandoc
sudo nala install -y python-is-python3 python3-pip python3-virtualenv pymol
sudo nala install -y wine winetricks
sudo nala install -y rclone
sudo nala install -y pkg-config
```

Note that `pandoc` may not be the latest version. One can go to
<https://github.com/jgm/pandoc/releases/latest>, download the latest
(`amd64`) `deb` file, and install with `nala`.

## Update GRUB to show progress during turning on/off (if preferred)

``` bash
sudo nano /etc/default/grub
```

Remove `quiet splash` for the line of `GRUB_CMDLINE_LINUX_DEFAULT=` of
the grub file, and then update the grub.

``` bash
sudo update-grub
```

## Install Ubuntu (if gnome is preferred)

``` bash
sudo nala install -y ubuntu-desktop
sudo nala install -y chrome-gnome-shell
sudo nala install -y gnome-sushi
```

It is strongly recommended to install several `gnome-shell` extensions
from <https://extensions.gnome.org/>

-   Dash to Panel

-   Resource Monitor

-   Bing Wallpaper

## Set up Box Drive

Use `rclone config` to set up the Box drive. Refer to
<https://rclone.org/box/> for details.

``` bash
cd ~
mkdir ~/Box
rclone config
```

Add shortcuts for mounting/unmounting Box Drive.

``` bash
echo "rclone mount box:/ ~/Box --vfs-cache-mode full --no-checksum --transfers 40 --vfs-read-chunk-streams 16 --vfs-read-chunk-size 4M --daemon" > ~/bin/boxmount
chmod +x ~/bin/boxmount
echo "fusermount -u ~/Box" > ~/bin/boxunmount
chmod +x ~/bin/boxunmount
boxmount
```
Note that `--vfs-read-chunk-streams` works for newer versions of `rclone`. You may need to download it from https://rclone.org/downloads/ and upgrade `rclone`

## Python

It is suggested that you install Python using `uv` or using
`Anaconda Distribution`

``` bash
cd ~/Downloads
wget 'https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-x86_64.sh'
chmod +x Anaconda3-2024.10-1-Linux-x86_64.sh 
./Anaconda3-2024.10-1-Linux-x86_64.sh 
```

After restarting the terminal, one can use `uv pip install` to install
various python packages. For example,

``` bash
uv pip install jupyterlab mdanalysis trackpy
```

## Chinese Input Method

-   Add Chinese in Language Support

-   Add Chinese - Rime for Input Methods in Ibus Preferences

-   Add `reset: 1` to `simplification` in
    `~/.config/ibus/rime/build/luna_pinyin.schema.yaml`

## Misc. Notes

-   **VMD**: download VMD from
    <https://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=VMD,>
    and install it following the Installation Guide at
    <https://www.ks.uiuc.edu/Research/vmd/current/ig/ig.html>

-   **GoldenDict**: dictionaries and config should be placed in
    `~/.goldendict`

-   **Startup Apps**: create `xxx.desktop` in the `~/.config/autostart/`
    folder

## WebCam

### USB WebCam

Sometimes, the auto-exposure does not work very well if there is high
reflection from the background. One can turn it off.

-   Get the device ID (`/dev/videoxxx`)

``` bash
sudo apt install v4l-utils
v4l2-ctl --list-devices
```

Turn off auto-exposure (and set exposure manually)

``` bash
4l2-ctl -d /dev/video9 -c auto_exposure=1
v4l2-ctl -d /dev/video9 -c exposure_time_absolute=300
```

### Build-in WebCam (DO NOT USE)

Dell Latitude 7440 build-in webcam does not work at the moment. Below
are some code that worked previously.

``` bash
uname -r
sudo nala install -y linux-modules-ipu6-6.8.0-48-generic linux-modules-ivsc-generic
sudo add-apt-repository ppa:oem-solutions-group/intel-ipu6
sudo nala update
sudo nala install -y libcamhal-ipu6ep0
sudo add-apt-repository -r ppa:oem-solutions-group/intel-ipu6 
```

## Disable Automatic Updater (Optional)
Sometimes, automatic updates (too early) will mess up the system. So it might be desired to disable the automatic updaters.
1. Disable Automatic Update Checks:
    - Open `Software & Updates`.
    - Go to the Updates tab.
    - Change the setting for Automatically check for updates to Never.
    - Close the window.
2. Disabling Unattended Upgrades
   - In terminal
     ```bash
     sudo nano /etc/apt/apt.conf.d/20auto-upgrades
     ```
   - Set `APT::Periodic::Update-Package-Lists` to `0`.
   - Set `APT::Periodic::Unattended-Upgrade` to `0`.
   - Save and close
   - Run
     ```bash
     sudo dpkg-reconfigure unattended-upgrades
     ```
     Make sure you select "No" and "Keep the local version ..." when being asked
3. Disable autostart of Update-Notifier
   - Edit `update-notifier.desktop`
     ```bash
     sudo nano /etc/xdg/autostart/update-notifier.desktop
     ```
   - Add `Hidden=true` to the end of the file (so that it will be treated as if it was deleted by the sytem)
4. Restart computer
     
