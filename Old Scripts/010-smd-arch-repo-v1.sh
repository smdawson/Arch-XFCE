#!/bin/bash
# credit  :  Erik Dubois
# https://github.com/arcolinuxd/arco-xfce
set -e
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

# software from my custom package repositories


echo "################################################################"
echo

sudo pacman -S smd-arch-arc-themes-nico-git --noconfirm --needed
sudo pacman -S smd-arch-conky-collection-git --noconfirm --needed
sudo pacman -S smd-arch-fonts-git --noconfirm --needed
sudo pacman -S smd-arch-geany-git --noconfirm --needed
sudo pacman -S smd-arch-hblock-git --noconfirm --needed
sudo pacman -S smd-arch-kvantum-git --noconfirm --needed
sudo pacman -S smd-arch-lightdm-gtk-greeter --noconfirm --needed
sudo pacman -S smd-arch-local-applications-git --noconfirm --needed
sudo pacman -S smd-arch-local-xfce4-git --noconfirm --needed
#sudo pacman -S smd-arch-mirrorlist-git --noconfirm --needed
sudo pacman -S smd-arch-neofetch-git --noconfirm --needed
#sudo pacman -S smd-arch-nitrogen-git --noconfirm --needed
sudo pacman -S smd-arch-pipemenus-git --noconfirm --needed
sudo pacman -S smd-arch-plank-git --noconfirm --needed
sudo pacman -S smd-arch-plank-themes-git --noconfirm --needed
sudo pacman -S smd-arch-qt5-git --noconfirm --needed
sudo pacman -S smd-arch-rofi-git --noconfirm --needed
sudo pacman -S smd-arch-rofi-themes-git --noconfirm --needed
sudo pacman -S smd-arch-root-git --noconfirm --needed
sudo pacman -S smd-arch-system-config-git --noconfirm --needed
sudo pacman -S smd-arch-termite-themes-git --noconfirm --needed
sudo pacman -S smd-arch-variety-git --noconfirm --needed
sudo pacman -S smd-arch-wallpapers-git --noconfirm --needed
sudo pacman -S smd-arch-xfce4-panel-profiles-git --noconfirm --needed
sudo pacman -S smd-arch-xfce-git --noconfirm --needed
sudo pacman -S smd-arch-config-xfce-git --noconfirm --needed
sudo pacman -S --noconfirm --needed  smd-arch-xfce-dconf-git


echo "################################################################"
echo "Copying all files and folders from /etc/skel to ~"
echo "################################################################"
echo
cp -rT /etc/skel ~
