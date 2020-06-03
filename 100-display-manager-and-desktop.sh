#!/bin/bash
#set -e
##################################################################################################################
# Credit	:	Erik Dubois
# We# Website	:	https://www.arcolinux.info
# Website	:	https://www.arcolinux.com
# Website	:	https://www.arcolinuxd.com
# Website	:	https://www.arcolinuxb.com
# Website	:	https://www.arcolinuxiso.com
# Website	:	https://www.arcolinuxforum.combsite	:	https://www.erikdubois.be
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

###############################################################################
echo "Installation of the core software"
###############################################################################

list=(
lightdm
smd-arch-lightdm-gtk-greeter
smd-arch-lightdm-gtk-greeter-settings
smd-arch-wallpapers-git
xfce4
xfce4-goodies
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

tput setaf 5;echo "################################################################"
echo "Enabling lightdm as display manager"
echo "################################################################"
echo;tput sgr0
sudo systemctl enable lightdm.service -f

tput setaf 2;echo "################################################################"
echo "Removing packages not needed"
echo "################################################################"
echo;tput sgr0
sudo pacman -R xfce4-artwork xfce4-screensaver --noconfirm

tput setaf 7;echo "################################################################"
echo "A very minimal functional desktop is now installed"
echo "################################################################"
echo;tput sgr0

tput setaf 11;
echo "################################################################"
echo "Reboot your system"
echo "################################################################"
echo;tput sgr0
