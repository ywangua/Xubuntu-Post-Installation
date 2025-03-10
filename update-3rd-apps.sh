#!/bin/bash
#
# Author: Yong Wang (yongwang@uark.edu)
# Description: update 3rd party apps
#   - vscode
#   - google chrome
#   - zoom
#
# This script is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3.
# This script is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program; if not, see <https://www.gnu.org/licenses/gpl-3.0.txt>

sudo nala update

cd 
cd Downloads

wget 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64' -O ./code_latest_amd64.deb
sudo nala install -y ./code_latest_amd64.deb

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O ./google-chrome-stable_current_amd64.deb
sudo nala install -y ./google-chrome-stable_current_amd64.deb

wget 'https://zoom.us/client/latest/zoom_amd64.deb' -O ./zoom_amd64.deb
sudo nala -y install ./zoom_amd64.deb

