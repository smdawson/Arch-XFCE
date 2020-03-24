#!/bin/bash
set -e
##################################################################################################################
# Author	:	Erik Dubois
# Website	:	https://www.erikdubois.be
# 
# Edit by	:	Seth Dawson
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################


echo "################################################################"
echo "###               Adding smd-archlinux repo's               ####"
echo "################################################################"

sudo pacman -S wget --noconfirm --needed
sudo wget https://raw.githubusercontent.com/smdawson/smd-archlinux-mirrorlist/master/etc/pacman.d/smd-archlinux-mirrorlist -O /etc/pacman.d/smd-archlinux-mirrorlist


echo '
#[smd_archlinux_repo_testing]
#SigLevel = Required DatabaseOptional
#Include = /etc/pacman.d/smd-archlinux-mirrorlist

[smd_archlinux_repo]
SigLevel = Required DatabaseOptional
Include = /etc/pacman.d/smd-archlinux-mirrorlist

[smd_archlinux_repo_3party]
SigLevel = Required DatabaseOptional
Include = /etc/pacman.d/smd-archlinux-mirrorlist' | sudo tee --append /etc/pacman.conf

sudo pacman -Syy

echo "Installing the official mirrorlist file now."
echo "It will overwrite the one we downloaded earlier on."

sudo pacman -S smd-archlinux-mirrorlist-git --noconfirm


echo "################################################################"
echo "###                  arcolinux repo's added                 ####"
echo "################################################################"
