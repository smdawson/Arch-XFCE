#!/bin/bash
set -e
# https://wiki.archlinux.org/index.php/Pacman/Package_signing#Adding_unofficial_keys

echo "Receiving Key for SMD-Arch Packages"
sudo pacman-key --recv-keys 4579ADF299687948
# sudo pacman-key --add /path/to/downloaded/keyfile
echo "Verify Fingerprint"
sudo pacman-key --finger 4579ADF299687948
echo "Local Sign Imported Key"
sudo pacman-key --lsign-key 4579ADF299687948
echo "Refresh Keys"
sudo pacman-key --refresh-keys

echo "~~~~~~~~~~~~~~~"
echo "|             |"
echo "|  key added  |"
echo "|             |"
echo "~~~~~~~~~~~~~~~"