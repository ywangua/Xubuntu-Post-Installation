# Xubuntu-Post-Installation
Notes for installing useful software/programs for research after installing Xubuntu 24.04

## Run the post-installation-script
* Download `xubuntu-post-install.sh`
* Make it runnable: `chmod +x ./xubuntu-post-install.sh`
* Run it: `./xubuntu-post-install.sh`

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
