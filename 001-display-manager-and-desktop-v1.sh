#!/bin/bash
set -e
##################################################################################################################
# Credit	:	Erik Dubois
# Website	:	https://www.erikdubois.be
# 
# Edit by	:	Seth Dawson
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################
echo "##################################################"
echo "#                                                #"
echo "#     Installing Display Manager and Desktop     #"
echo "#                                                #"
echo "##################################################"

sudo pacman -Syyu --noconfirm
#installing displaymanager or login manager
sudo pacman -S --noconfirm --needed lightdm smd-lightdm-gtk-greeter smd-lightdm-gtk-greeter-settings smd-wallpapers-git
#installing desktop environment
sudo pacman -S xfce4 xfce4-goodies --noconfirm --needed
#enabling displaymanager or login manager
sudo systemctl enable lightdm.service -f
sudo systemctl set-default graphical.target

#remove xfce stuff
sudo pacman -R xfce4-artwork xfce4-screensaver --noconfirm

echo "##################################################"
echo "#                                                #"
echo "#  Display Manager and Desktop Install Complete  #"
echo "#                                                #"
echo "##################################################"