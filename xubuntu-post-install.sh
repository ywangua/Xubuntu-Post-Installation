#!/bin/bash
#
# Author: Yong Wang (yongwang@uark.edu)
# Description: a post-installation bash script for Xubuntu, tailored for research laptop used in our laboratory
#
# This script is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3.
# This script is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program; if not, see <https://www.gnu.org/licenses/gpl-3.0.txt>

clear
echo "**************************************************"
echo "*        Post-Install Script for Xubuntu         *"
echo "**************************************************"
echo ""

echo "[INFO]: Update System and Install nala"
sudo apt update
sudo apt install -y nala
sudo nala update
sudo nala upgrade
echo ""
echo ""
read -p "Press <Enter> to Continue ..."

