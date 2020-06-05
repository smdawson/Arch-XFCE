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
	if pacman -Qi $1 &> /dev/null; then
			echo -e " [${g}✔${endc}]::[${b}"$1"${enda}] Is Already Installed!"
	else
		if pacman -Qi yay &> /dev/null; then
			echo -e " ${y}Installing with yay ${endc}"
			yay -S --noconfirm $1
		elif pacman -Qi trizen &> /dev/null; then
			echo -e " ${y}Installing with trizen ${endc}"
			trizen -S --noconfirm --needed --noedit $1
		fi
	fi
		# Verify Successful Installation
		if pacman -Qi $1 &> /dev/null; then
			echo -e " [${g}✔${endc}]::[${b}"$1"${enda}]: Installed!"
		else
			echo -e " [${r}!${endc}]::[${b}"$1"${enda}]: ${r}NOT Installed!${endc}"
		fi
}

function category {
	tput setaf 5;
	echo "################################################################"
	echo "Installing software for category " $1
	echo "################################################################"
	echo;tput sgr0
}

checkyay && checktrizen && checkgit && checkwget

###############################################################################

category Distro_Specific

list=(
mugshot
menulibre
xfce4-panel-profiles
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	aurinstall $name
done

###############################################################################

category Accessories

list=(
conky-lua-archers-git
mintstick-git
bitwarden-bin
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	aurinstall $name
done

###############################################################################

category Development

list=(
sublime-text-dev
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	aurinstall $name
done

###############################################################################

category Fun_Stuff

list=(
bash-pipes
boxes
gotop-bin
hollywood
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	aurinstall $name
done

###############################################################################

category Multimedia

list=(
gradio
pithos
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	aurinstall $name
done

###############################################################################

category Office

list=(
joplin
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	aurinstall $name
done

###############################################################################

category System

list=(
bibata-cursor-theme
downgrade
font-manager-git
inxi
numix-circle-icon-theme-git
oxy-neon
pamac-aur
sardi-icons
sardi-orb-colora-variations-icons-git
sardi-orb-colora-mixing-icons-git
sardi-mono-papirus-colora-variations-icons-git
sardi-mono-numix-colora-variations-icons-git
sardi-mono-mixing-icons-git
sardi-mono-colora-variations-icons-git
sardi-mixing-icons-git
sardi-ghost-flexible-variations-icons-git
sardi-ghost-flexible-mixing-icons-git
sardi-ghost-flexible-colora-variations-icons-git
sardi-flexible-variations-icons-git
sardi-flexible-mixing-icons-git
sardi-flexible-luv-colora-variations-icons-git
sardi-flexible-colora-variations-icons-git
sardi-flat-mixing-icons-git
sardi-flat-colora-variations-icons-git
sardi-colora-variations-icons-git
surfn-icons-git
the_platinum_searcher-bin
ttf-mac-fonts
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	aurinstall $name
done

###############################################################################

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

###############################################################################

category Last

list=(
hardcode-fixer-git
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	aurinstall $name
done

###############################################################################

sudo hardcode-fixer

echo -e " [${g}✔${endc}]::Software From ${b}${r}[Arch User Repository]${endc}${enda} Installed"
echo
echo -e " ${bu}SMD-Arch Installation Script Version${b} $version ${enda} ${endc}"
