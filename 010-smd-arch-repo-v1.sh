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

sudo pacman -S arcolinux-arc-themes-nico-git --noconfirm --needed
sudo pacman -S arcolinux-conky-collection-git --noconfirm --needed
sudo pacman -S arcolinux-cron-git --noconfirm --needed
sudo pacman -S arcolinux-fonts-git --noconfirm --needed
sudo pacman -S arcolinux-geany-git --noconfirm --needed
sudo pacman -S arcolinux-hblock-git --noconfirm --needed
sudo pacman -S arcolinux-kvantum-git --noconfirm --needed
sudo pacman -S arcolinux-lightdm-gtk-greeter --noconfirm --needed
sudo pacman -S arcolinux-local-applications-git --noconfirm --needed
sudo pacman -S arcolinux-local-xfce4-git --noconfirm --needed
sudo pacman -S arcolinux-mirrorlist-git --noconfirm --needed
sudo pacman -S arcolinux-neofetch-git --noconfirm --needed
#sudo pacman -S arcolinux-nitrogen-git --noconfirm --needed
sudo pacman -S arcolinux-pipemenus-git --noconfirm --needed
sudo pacman -S arcolinux-plank-git --noconfirm --needed
sudo pacman -S arcolinux-plank-themes-git --noconfirm --needed
sudo pacman -S arcolinux-qt5-git --noconfirm --needed
sudo pacman -S arcolinux-rofi-git --noconfirm --needed
sudo pacman -S arcolinux-rofi-themes-git --noconfirm --needed
sudo pacman -S arcolinux-root-git --noconfirm --needed
sudo pacman -S arcolinux-system-config-git --noconfirm --needed
sudo pacman -S arcolinux-termite-themes-git --noconfirm --needed
sudo pacman -S arcolinux-variety-git --noconfirm --needed
sudo pacman -S arcolinux-wallpapers-git --noconfirm --needed
sudo pacman -S arcolinux-xfce4-panel-profiles-git --noconfirm --needed
sudo pacman -S arcolinux-xfce-git --noconfirm --needed
sudo pacman -S arcolinux-config-xfce-git --noconfirm --needed
sudo pacman -S --noconfirm --needed  arcolinux-xfce-dconf-git


echo "################################################################"
echo "Copying all files and folders from /etc/skel to ~"
echo "################################################################"
echo
cp -rT /etc/skel ~
