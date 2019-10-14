#!/bin/bash
set -e
#
##########################################################
#                 Arch-XFCE script                       #
#  ArchLinux Applications Automatic Installation Script  #
#  Forked and modified from                              #
#  https://github.com/SofianeHamlaoui/ArchI0             #
##########################################################
#  +FIRST  : sudo chmod +x archxi.sh                     #
#                (Give EXEC Access To Script)            #
#  +TO RUN    : sudo ./arcxi.sh                          #
##########################################################
#                                                        #
#                DO NOT JUST RUN THIS.                   #
#       EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.         #
#                                                        #
##########################################################
#
# Variables
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
version="20191014"
spath="$( cd "$( dirname $0 )" && pwd )"

# ArchXI Logo
function showlogo {
  clear
  echo -e " 
 ##########################################################
 #                                                        #
 #                   ArchXI script                        #
 #                                                        #
 #  Script to Install and Setup Desktop and Applications  #
 #           After a Fresh Arch Linux Install             #
 #                                                        #
 ##########################################################
 #                                                        #
 #           Designed For My Personal Use                 #
 #        EXAMINE AND UNDERSTAND BEFORE USING.            # 
 #                ${r}RUN AT YOUR OWN RISK.${endc}                   #
 #                                                        #
 ##########################################################"
  echo && echo -e " Version:" $g $b $version $endc $enda
  
  echo && echo -en " ${y}Press Enter To Contunue${endc}"
  echo
  read input
}

#ROOT User Check
function checkroot {
  if [[ $(id -u) = 0 ]]; then
    echo -e " Checking For ROOT: ${g}PASSED${endc}"
  else
    echo -e " Checking For ROOT: ${r}FAILED${endc}
 ${y}This Script Needs To Run As ROOT${endc}"
    echo -e " ${b}archxi.sh${enda} Will Now Exit"
    echo
    sleep 1
    exit
  fi
  echo
}

# Initial pacman -Syu
function initpacmanupd {
  echo 
  echo -e "${b} Updating ..... ${enda}${r} | Please stop any install process before updating${endc}"
  echo
  pacman -Syyu --noconfirm
  echo "Update Completed" 
  echo
  sleep 1
}

# Requirements Check 

# Install Yay
function checkyay {
  which yay > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
	echo -e " [${g}✔${endc}]::[${b}Yay${enda}]: installation found!"
else

echo -e " [${r}x${endc}]::[${b}warning${enda}]:this script requires AUR Helpers"
echo && echo -e " ${b}[!]::[please wait]: Installing Yay ..${enda}"
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si 
echo
fi
echo
sleep 1
}

# Install Trizen
function checktrizen {
  which trizen > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
	echo -e " [${g}✔${endc}]::[${b}Trizen${enda}]: installation found!"
else

echo -e " [${r}x${endc}]::[${b}warning${enda}]:this script requires AUR Helpers"
echo && echo -e " ${b}[!]::[please wait]: Installing Trizen ..${enda}"
git clone https://aur.archlinux.org/trizen.git && cd trizen && makepkg -si 
echo ""
fi
sleep 1
}

#Install Git
function checkgit {
	which git > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
	echo -e " [${g}✔${endc}]::[${b}Git${enda}]: installation found!"
else

echo -e " [${r}x${endc}]::[${b}warning${enda}]:this script requires Git"
echo && echo -e " ${b}[!]::[please wait]: Installing Git ..${enda}"
pacman -S git --noconfirm
echo ""
fi
sleep 1
}

#Install wget
function checkwget {
	which wget > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
	echo -e " [${g}✔${endc}]::[${b}Wget${enda}]: installation found!"
else

echo -e " [${r}x${endc}]::[${b}warning${enda}]:this script requires Wget"
echo && echo -e " ${b}[!]::[please wait]: Installing Wget ..${enda}"
pacman -S --noconfirm wget
sleep 2
echo ""
fi
sleep 1
} 

#Add Key Servers
function addkeyservers {
 [ -d $HOME"/.gnupg" ] || mkdir -p $HOME"/.gnupg"

 echo '
 keyserver hkp://pool.sks-keyservers.net:80
 keyserver hkps://hkps.pool.sks-keyservers.net:443
 keyserver hkp://ipv4.pool.sks-keyservers.net:11371' | tee --append ~/.gnupg/gpg.conf

 chmod 600 ~/.gnupg/gpg.conf
 chmod 700 ~/.gnupg

 echo -e " ${b}[!]::[please wait]:  Adding keyservers to the /etc/pacman.d/gnupg folder for the use with pacman...${enda}"

 echo '
 keyserver hkp://pool.sks-keyservers.net:80
 keyserver hkps://hkps.pool.sks-keyservers.net:443
 keyserver hkp://ipv4.pool.sks-keyservers.net:11371' | sudo tee --append /etc/pacman.d/gnupg/gpg.conf

 echo -e " [${g}✔${endc}]::[${b}Keyservers${enda}] Added"
 sleep 1
}

# Add Trust Key
function trustkey {
 echo -e " ${b}[!]::[please wait]: Receiving, local signing and refreshing keys...${enda}"

 pacman-key -r 74F5DE85A506BF64
 pacman-key --lsign-key 74F5DE85A506BF64
 pacman-key --refresh-keys

 echo -e " [${g}✔${endc}]::[${b}Key Trusted${enda}] "
 sleep 1
}

# Add Arcolinux Repos
function arcolinuxrepos {
 echo -e " ${b}[!]::[please wait]:  Getting the Latest Arcolunux Mirrors File...${enda}"

 pacman -S wget --noconfirm --needed
 wget https://raw.githubusercontent.com/arcolinux/arcolinux-mirrorlist/master/etc/pacman.d/arcolinux-mirrorlist -O /etc/pacman.d/arcolinux-mirrorlist


 echo '
 #[arcolinux_repo_testing]
 #SigLevel = Required DatabaseOptional
 #Include = /etc/pacman.d/arcolinux-mirrorlist
 [arcolinux_repo]
 SigLevel = Required DatabaseOptional
 Include = /etc/pacman.d/arcolinux-mirrorlist
 [arcolinux_repo_3party]
 SigLevel = Required DatabaseOptional
 Include = /etc/pacman.d/arcolinux-mirrorlist
 [arcolinux_repo_submicron]
 SigLevel = Required DatabaseOptional
 Include = /etc/pacman.d/arcolinux-mirrorlist' | sudo tee --append /etc/pacman.conf

 pacman -Syy

 echo -e " ${b}[!]::[please wait]:  Installing the Offical Mirrorlist File Now...${enda}"
 echo "Installing the official mirrorlist file now."

 pacman -S arcolinux-mirrorlist-git --noconfirm

 echo -e " [${g}✔${endc}]::[${b}Arcolunux Repo's Added${enda}] "
 sleep 1
}
showlogo && checkroot && initpacmanupd && checkyay  && checktrizen && checkgit && checkwget
addkeyservers && addtrustkey && aroclinuxrepos && initpacmanupd

# Install software used in .bashrc
echo -e " ${b}[!]::[please wait]:  Installing Software used in .bashrc...${enda}"
pacman -S --noconfirm --needed expac hwinfo reflector youtube-dl
echo -e " [${g}✔${endc}]::[${b}.bashrc Software${enda}]: Installed!"
echo
sleep 1

# Install Display Manager and Desktop
echo -e " ${b}[!]::[please wait]:  Installing Display Manager and XFCE Desktop...${enda}"
pacman -Syyu --noconfirm
#installing displaymanager or login manager
pacman -S --noconfirm --needed lightdm arcolinux-lightdm-gtk-greeter arcolinux-lightdm-gtk-greeter-settings arcolinux-wallpapers-git  
#installing desktop environment
pacman -S --noconfirm --needed xfce4 xfce4-goodies
#enabling displaymanager or login manager
systemctl enable lightdm.service -f
systemctl set-default graphical.target
#Remove xfce4 artwork
pacman -R xfce4-artwork --noconfirm
echo -e " [${g}✔${endc}]::[${b}Display Manager and XFCE Desktop${enda}]: Installed!"
echo
sleep 1

# Install Sound Software
echo -e " ${b}[!]::[please wait]:  Installing Display Sound Software...${enda}"
pacman -S --noconfirm --needed pulseaudio pulseaudio-alsa pavucontrol alsa-utils alsa-plugins alsa-lib alsa-firmware
pacman -S --noconfirm --needed gstreamer gst-plugins-good gst-plugins-bad gst-plugins-base gst-plugins-ugly
pacman -S --noconfirm --needed volumeicon playerctl
echo -e " [${g}✔${endc}]::[${b}Sound Software${enda}]: Installed!"
echo
sleep 1

# Install Printer Management
echo -e " ${b}[!]::[please wait]:  Installing Print Management Software...${enda}"
pacman -S --noconfirm --needed cups cups-pdf ghostscript gsfonts gutenprint gtk3-print-backends libcups hplip system-config-printer
systemctl enable org.cups.cupsd.service
echo -e " [${g}✔${endc}]::[${b}Print Management Software${enda}]: Installed!"
echo
sleep 1