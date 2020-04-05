#!/bin/bash
# credit  :  Erik Dubois
# https://github.com/arcolinuxd/arco-xfce
set -e
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

# software from standard Arch Linux repositories
# Core, Extra, Community, Multilib repositories
echo "Installing the software ArcoLinux uses in .bashrc"

sudo pacman -S --noconfirm --needed asciiquarium cmatrix cool-retro-term cowfortune fortune-mod mc ranger sl

echo "Installing category Accessories"

sudo pacman -S --noconfirm --needed catfish cronie galculator gnome-screenshot plank xfburn variety yad

echo "Installing category Development"

sudo pacman -S --noconfirm --needed atom devtools geany meld

echo "Installing category Fun Stuff"

sudo pacman -S --noconfirm --needed atom devtools geany meld

echo "Installing category Games"

sudo pacman -S --noconfirm --needed kmines steam-native-runtime steam supertuxkart

echo "Installing category Graphics"

sudo pacman -S --noconfirm --needed gimp gnome-font-viewer gpick inkscape nomacs ristretto

echo "Installing category Internet"

sudo pacman -S --noconfirm --needed discord firefox hexchat qbittorrent telegram-desktop

echo "Installing category Multimedia"

sudo pacman -S --noconfirm --needed audacity deadbeef peek simplescreenrecorder vlc

echo "Installing category Office"

sudo pacman -S --noconfirm --needed evince evolution gnucash hunspell hunspell-en_US hyphen hyphen-en libmythes mythes-en libreoffice-fresh

echo "Installing category System"

sudo pacman -S --noconfirm --needed arc-gtk-theme accountsservice baobab curl dconf-editor dmenu dmidecode ffmpegthumbnailer git glances gnome-disk-utility gnome-keyring gparted go 
sudo pacman -S --noconfirm --needed grsync gtk-engine-murrine gvfs gvfs-mtp hardinfo hddtemp htop imagemagick kvantum-qt5 kvantum-theme-arc lm_sensors lsb-release mlocate neofetch
sudo pacman -S --noconfirm --needed net-tools noto-fonts numlockx polkit-gnome qt5ct sane screenfetch scrot simple-scan sysstat termite thunar thunar-archive-plugin thunar-volman 
sudo pacman -S --noconfirm --needed tumbler virtualbox-host-modules-arch virtualbox vnstat w3m wget wmctrl unclutter rxvt-unicode urxvt-perls xclip xdg-user-dirs xdo xdotool xfce4-notifyd 
sudo pacman -S --noconfirm --needed zenity zsh zsh-completions zsh-syntax-highlighting 

echo "################################################################"
echo "##      Removing all the messages virtualbox produces         ##"
echo "################################################################"
VBoxManage setextradata global GUI/SuppressMessages "all"

echo "################################################################"
echo "#########              MUST REBOOT                     #########"
echo "################################################################"

###############################################################################################

# installation of zippers and unzippers
sudo pacman -S --noconfirm --needed unace unrar zip unzip sharutils  uudeview  arj cabextract file-roller

###############################################################################################


echo "################################################################"
echo "#### Software from standard Arch Linux Repo installed  #########"
echo "################################################################"
