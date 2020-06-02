#!/bin/bash
# credit  :  Erik Dubois
# https://github.com/arcolinuxd/arco-xfce
#set -e
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

# software from my custom package repositories
###############################################################################
#
#   DECLARATION OF FUNCTIONS
#
###############################################################################


func_install() {
	if pacman -Qi $1 &> /dev/null; then
		tput setaf 2
  		echo "###############################################################################"
  		echo "################## The package "$1" is already installed"
      	echo "###############################################################################"
      	echo
		tput sgr0
	else
    	tput setaf 3
    	echo "###############################################################################"
    	echo "##################  Installing package "  $1
    	echo "###############################################################################"
    	echo
    	tput sgr0
    	sudo pacman -S --noconfirm --needed $1
    fi
}

func_category() {
	tput setaf 5;
	echo "################################################################"
	echo "Installing software for category " $1
	echo "################################################################"
	echo;tput sgr0
}

###############################################################################

func_category SMD-Arch-Linux

list=(
smd-arch-arc-themes-nico-git
smd-arch-conky-collection-git
smd-arch-fonts-git
smd-arch-geany-git
smd-arch-hblock-git
smd-arch-kvantum-git
smd-arch-lightdm-gtk-greeter
smd-arch-local-applications-git
smd-arch-local-xfce4-git
smd-arch-neofetch-git
smd-arch-pipemenus-git 
smd-arch-plank-git 
smd-arch-plank-themes-git 
smd-arch-qt5-git 
smd-arch-rofi-git 
smd-arch-rofi-themes-git 
smd-arch-root-git 
smd-arch-system-config-git 
smd-arch-termite-themes-git 
smd-arch-variety-git 
smd-arch-wallpapers-git 
smd-arch-xfce4-panel-profiles-git 
smd-arch-xfce-git 
smd-arch-config-xfce-git 
smd-arch-xfce-dconf-git
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	func_install $name
done
###############################################################################

tput setaf 6;echo "################################################################"
echo "Copying all files and folders from /etc/skel to ~"
echo "################################################################"
echo;tput sgr0
cp -Rf ~/.config ~/.config-backup-$(date +%Y.%m.%d-%H.%M.%S) && cp -rf /etc/skel/* ~

tput setaf 11;
echo "################################################################"
echo "Software has been installed"
echo "################################################################"
echo;tput sgr0
