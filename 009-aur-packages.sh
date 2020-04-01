##!/bin/bash
set -e
#
##########################################################
#                                                        #
#                 Arch-XFCE script                       #
#  ArchLinux Applications Automatic Installation Script  #
#  Inspired and Forked From                              #
#  https://github.com/SofianeHamlaoui/ArchI0             #
#  And                                                   #
#  https://github.com/arcolinuxd/arco-xfce               #
##########################################################
#  +FIRST  : sudo chmod +x arch-xfce.sh                  #
#                (Give EXEC Access To Script)            #
#  +TO RUN    : ./arch-xfce.sh                           #
##########################################################
#                                                        #
#                DO NOT JUST RUN THIS.                   #
#       EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.         #
#                                                        #
##########################################################
#
#  TO DO:
#
######################## Variables #######################
#
# b=bold u=underline bl=black r=red g=green
# y=yellow bu=blue m=magenta c=cyan w=white
# endc=end-color enda=end-argument
b='\033[1m'
u='\033[4m'
bl='\E[30m'
r='\E[31m'
g='\E[32m'
y='\E[33m'
bu='\E[34m'
m='\E[35m'
c='\E[36m'
w='\E[37m'
endc='\E[0m'
enda='\033[0m'
version="20200322"
##### Preliminary Requirements #####

# Install Yay
function checkyay {
  which yay > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
	echo -e " [${g}✔${endc}]::[${b}Yay${enda}]: installation found!"
else

echo -e " [${r}x${endc}]::[${b}warning${enda}]:this script requires AUR Helpers"
echo && echo -e " ${b}[!]::[please wait]: Installing Yay ..${enda}"
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm
cd ..
rm -rf yay
echo ""
fi
sleep 3
}

# Install Trizen
function checktrizen {
  which trizen > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
	echo -e " [${g}✔${endc}]::[${b}Trizen${enda}]: installation found!"
else

echo -e " [${r}x${endc}]::[${b}warning${enda}]:this script requires AUR Helpers"
echo && echo -e " ${b}[!]::[please wait]: Installing Trizen ..${enda}"
git clone https://aur.archlinux.org/trizen.git && cd trizen && makepkg -si --noconfirm
cd ..
rm -rf trizen
echo ""
fi
sleep 3
}

#Install Git
function checkgit {
	which git > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
	echo -e " [${g}✔${endc}]::[${b}Git${enda}]: installation found!"
else

echo -e " [${r}x${endc}]::[${b}warning${enda}]:this script requires Git"
echo && echo -e " ${b}[!]::[please wait]: Installing Git ..${enda}"
sudo pacman -S git --noconfirm
echo ""
fi
sleep 3
}

#Install wget
function checkwget {
	which wget > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
	echo -e " [${g}✔${endc}]::[${b}Wget${enda}]: installation found!"
else

echo -e " [${r}x${endc}]::[${b}warning${enda}]:this script requires Wget"
echo && echo -e " ${b}[!]::[please wait]: Installing Wget ..${enda}"
sudo pacman -S --noconfirm wget
sleep 2
echo
fi
sleep 3
}

function aurinstall {
	#----------------------------------------------------------------------------------
	# Check If Package Is Installed
	if pacman -Qi $package &> /dev/null; then
			echo -e " [${g}✔${endc}]::[${b}"$package"${enda}] Is Already Installed!"
	else
		if pacman -Qi yay &> /dev/null; then
			echo -e " ${y}Installing with yay ${endc}"
			yay -S --noconfirm $package
		elif pacman -Qi trizen &> /dev/null; then
			echo -e " ${y}Installing with trizen ${endc}"
			trizen -S --noconfirm --needed --noedit $package
		fi
	fi
		# Verify Successful Installation
		if pacman -Qi $package &> /dev/null; then
			echo -e " [${g}✔${endc}]::[${b}"$package"${enda}]: Installed!"
		else
			echo -e " [${r}!${endc}]::[${b}"$package"${enda}]: ${r}NOT Installed!${endc}"
		fi
}

checkyay && checktrizen && checkgit && checkwget

echo "Installing Category Distro Specific"

package="mugshot"
aurinstall

package="menulibre"
aurinstall

package="xfce4-panel-profiles"
aurinstall

echo "Installing category Accessories"

package="conky-lua-archers-git"
aurinstall

package="python2-pyparted"
aurinstall

package="mintstick-git"
aurinstall


package="bitwarden-bin"
aurinstall

echo "Installing category Development"

package="sublime-text-dev"
aurinstall

echo "Installing category Fun Stuff"

package="bash-pipes"
aurinstall

package="boxes"
aurinstall

package="gotop-bin"
aurinstall

echo "Installing category Multimedia"

package="gradio"
aurinstall

package="radiotray"
aurinstall

package="pithos"
aurinstall

echo "Installing category Office"

package="joplin"
aurinstall

echo "Installing category System"

package="bibata-cursor-theme"
aurinstall

package="downgrade"
aurinstall

package="font-manager-git"
aurinstall

package="inxi"
aurinstall

package="numix-circle-icon-theme-git"
aurinstall

package="oxy-neon"
aurinstall

package="pamac-aur"
aurinstall

package="sardi-icons"
aurinstall

package="sardi-orb-colora-variations-icons-git"
aurinstall

package="sardi-orb-colora-mixing-icons-git"
aurinstall

package="sardi-mono-papirus-colora-variations-icons-git"
aurinstall

package="sardi-mono-numix-colora-variations-icons-git"
aurinstall

package="sardi-mono-mixing-icons-git"
aurinstall

package="sardi-mono-colora-variations-icons-git"
aurinstall

package="sardi-mixing-icons-git"
aurinstall

package="sardi-ghost-flexible-variations-icons-git"
aurinstall

package="sardi-ghost-flexible-mixing-icons-git"
aurinstall

package="sardi-ghost-flexible-colora-variations-icons-git"
aurinstall

package="sardi-flexible-variations-icons-git"
aurinstall

package="sardi-flexible-mixing-icons-git"
aurinstall

package="sardi-flexible-luv-colora-variations-icons-git"
aurinstall

package="sardi-flexible-colora-variations-icons-git"
aurinstall

package="sardi-flat-mixing-icons-git"
aurinstall

package="sardi-flat-colora-variations-icons-git"
aurinstall

package="sardi-colora-variations-icons-git"
aurinstall

package="screenkey-git"
aurinstall

package="surfn-icons-git"
aurinstall

package="the_platinum_searcher-bin"
aurinstall

package="ttf-mac-fonts"
aurinstall

echo "################################################################"
echo "downloading Oh-My-Zsh from github"
echo "################################################################"

wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh

# changing the theme to random so you can enjoy tons of themes.

sudo sed -i 's/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"random\"/g' ~/.zshrc

# If above line did not work somehow. This is what you should do to enjoy the many themes.
# go find the hidden .zshrc file and look for ZSH_THEME="robbyrussell" (CTRL+H to find hidden files)
# change this to ZSH_THEME="random"

echo '
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
neofetch
' >>  ~/.zshrc

# these come always last

package="hardcode-fixer-git"
aurinstall

sudo hardcode-fixer

echo "################################################################"
echo "####        Software from AUR Repository installed        ######"
echo "################################################################"
