#!/bin/bash
#
##########################################################
#                 Arch-XFCE script                       #
#  ArchLinux Applications Automatic Installation Script  #
#  Forked and modified from                              #
#  https://github.com/SofianeHamlaoui/ArchI0             #
##########################################################
#  +FIRST  : sudo chmod +x arch-xfce.sh                  #
#                (Give EXEC Access To Script)            #
#  +TO RUN    : sudo ./arch-xfce.sh                      #
##########################################################
#                                                        #
#                DO NOT JUST RUN THIS.                   #
#       EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.         #
#                                                        #
##########################################################
#  START WITH 500
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
version="20180904"
spath="$( cd "$( dirname $0 )" && pwd )"
######################################1ST PART###################################################

# ArchI0 Logo
function showlogo {
  clear

echo """

   _____                .__      ____  ___.___ 
  /  _  \_______   ____ |  |__   \   \/  /|   |
 /  /_\  \_  __ \_/ ___\|  |  \   \     / |   |
/    |    \  | \/\  \___|   Y  \  /     \ |   |
\____|__  /__|    \___  >___|  / /___/\  \|___|
        \/            \/     \/        \_/     
          Arch Linux XFCE Installer


""";
    echo
}

# ROOT User Check
function checkroot {
  showlogo && sleep 1
  if [[ $(id -u) = 0 ]]; then
    echo -e " Checking For ROOT: ${g}PASSED${endc}"
  else
    echo -e " Checking For ROOT: ${r}FAILED${endc}
 ${y}This Script Needs To Run As ROOT${endc}"
    echo -e " ${b}ArchI0.sh${enda} Will Now Exit"
    echo
    sleep 1
    exit
  fi
}

# Initial pacman -Syu
function initpacmanupd {
  echo ""
  echo; echo -e "\033[1m Updating ..... \e[0m\E[31m| Please stop any install process before updating\e[0m"; 
  echo
  pacman -Syyu --noconfirm; 
  echo "Update Completed"; 
  sleep 1;
}

# Requirements Check 

function checkyay {
  which yay > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
	echo [✔]::[Yay]: installation found!;
else

echo [x]::[warning]:this script requires AUR Helpers ;
echo ""
echo [!]::[please wait]: Installing Yay ..  ;
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si 
echo ""
fi
sleep 1
}

function checktrizen {
  which trizen > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
	echo [✔]::[Trizen]: installation found!;
else

echo [x]::[warning]:this script requires AUR Helpers ;
echo ""
echo [!]::[please wait]: Installing Trizen ..  ;
git clone https://aur.archlinux.org/trizen.git && cd trizen && makepkg -si 
echo ""
fi
sleep 1
}

function checkgit {
	which git > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
	echo [✔]::[Git]: installation found!;
else

echo [x]::[warning]:this script require Git ;
echo ""
echo [!]::[please wait]: Installing Git ..  ;
pacman -S git --noconfirm
echo ""
fi
sleep 1
}

function checkwget {
	which wget > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
	echo [✔]::[wget]: installation found!;
else

echo [x]::[warning]:this script require wget ;
echo ""
echo [!]::[please wait]: Installing Wget ;
pacman -S --noconfirm wget
echosleep 2
echo ""
fi
sleep 1

}

# Script Initiation
checkroot && sleep 1
checkwget && checkgit && checkyay && checktrizen && sleep 1
showlogo && echo -e " ${y} Preparing To Run ${b}Arch-XFCE Installer${endc}"
initpacmanupd && clear && sleep 1
#################################################################################################
#######################################2ND PART##################################################
######### Programs Installations : START :  ##########################

# Adding keyservers to your personal .gpg for future applications
function addkeyserver {
 echo
 echo -e " Currently Adding ${b}Keyservers${enda}"
 echo && echo -en " ${y}Press Enter To Continue${endc}"
 read input
 echo -e " Adding ${b}Keyservers${enda}"
 [ -d $HOME"/.gnupg" ] || mkdir -p $HOME"/.gnupg"

 echo -e "Adding keyservers to your personal .gpg for future applications"
 echo -e "that require keys to be imported with yay for example"

 echo '
 keyserver hkp://pool.sks-keyservers.net:80
 keyserver hkps://hkps.pool.sks-keyservers.net:443
 keyserver hkp://ipv4.pool.sks-keyservers.net:11371' | tee --append ~/.gnupg/gpg.conf

 chmod 600 ~/.gnupg/gpg.conf
 chmod 700 ~/.gnupg

 echo -e "Adding keyservers to the /etc/pacman.d/gnupg folder for the use with pacman"

 echo '
 keyserver hkp://pool.sks-keyservers.net:80
 keyserver hkps://hkps.pool.sks-keyservers.net:443
 keyserver hkp://ipv4.pool.sks-keyservers.net:11371' | sudo tee --append /etc/pacman.d/gnupg/gpg.conf
 echo -e " ${b}Keyservers${enda} Were Successfully Added"
 echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
 echo
 read input
}

function addtrustkey {
 echo
 echo -e " Currently Adding ${b}Trust Keys${enda}"
 echo && echo -en " ${y}Press Enter To Continue${endc}"
 read input
 echo -e " Adding ${b}Trust Keys${enda}"
 echo -e "Receiving, local signing and refreshing keys"

 pacman-key -r 74F5DE85A506BF64
 pacman-key --lsign-key 74F5DE85A506BF64
 pacman-key --refresh-keys
 echo -e " ${b}Trust Keys${enda} Were Successfully Added"
 echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
 echo
 read input
}

function addarcolinux {
 echo
 echo -e " Currently Adding ${b}Arcolinux Repositories${enda}"
 echo && echo -en " ${y}Press Enter To Continue${endc}"
 read input
 echo -e " Adding ${b}Arcolinux Repositories${enda}"
 echo -e "Getting the latest arcolinux mirrors file"

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

 echo -e "Installing the official mirrorlist file now."
 echo -e "It will overwrite the one we downloaded earlier on."

 pacman -S arcolinux-mirrorlist-git --noconfirm

 echo -e " ${b}Arcolinux Repository${enda} Was Successfully Added"
 echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
 echo
 read input
}

function addbash {
 echo
 echo -e " Currently Installing ${b}Software Used In .bashrc${enda}"
 echo && echo -en " ${y}Press Enter To Continue${endc}"
 read input
 echo -e " Installing ${b}Software Used In .bashrc${enda}"

 pacman -S --noconfirm --needed expac
 pacman -S --noconfirm --needed hwinfo
 pacman -S --noconfirm --needed reflector
 pacman -S --noconfirm --needed youtube-dl
 echo -e " ${b}.bashrc Software${enda} Was Successfully Installed"
 echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
 echo
 read input
}

# Install Display Manager and Desktop
function installdesktop {
 #installing displaymanager or login manager
 echo
 echo -e " Currently Installing ${b}LightDM${enda}"
 echo && echo -en " ${y}Press Enter To Continue${endc}"
 read input
 echo -e " Installing ${b}LightDM${enda}"
 pacman -S --noconfirm --needed lightdm
 pacman -S --noconfirm --needed arcolinux-lightdm-gtk-greeter arcolinux-lightdm-gtk-greeter-settings
 pacman -S --noconfirm --needed arcolinux-wallpapers-git 
 echo -e " ${b}LightDM${enda} Was Successfully Installed"
 #installing desktop environment
 echo -e " Currently Installing ${b}XFCE{enda}"
 echo && echo -en " ${y}Press Enter To Continue${endc}"
 read input
 echo -e " Installing ${b}XFCE${enda}"
 pacman -S xfce4 xfce4-goodies --noconfirm --needed
 echo -e " ${b}XFCE${enda} Was Successfully Installed"
 #enabling displaymanager or login manager
 echo -e " Currently Enabling Display Manager"
 echo && echo -en " ${y}Press Enter To Continue${endc}"
 read input
 systemctl enable lightdm.service -f
 systemctl set-default graphical.target
 echo -e " ${b}Desktop${enda} Was Successfully Installed"
 echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
 echo
 read input
}

# Install Sound
function installsound {
 echo
 echo -e " Currently Installing ${b}Sound Software${enda}"
 echo && echo -en " ${y}Press Enter To Continue${endc}"
 read input
 echo -e " Installing ${b}Sound Software${enda}"
 pacman -S pulseaudio --noconfirm --needed
 pacman -S pulseaudio-alsa --noconfirm --needed
 pacman -S pavucontrol  --noconfirm --needed
 pacman -S alsa-utils alsa-plugins alsa-lib alsa-firmware --noconfirm --needed
 pacman -S gstreamer --noconfirm --needed
 pacman -S gst-plugins-good gst-plugins-bad gst-plugins-base gst-plugins-ugly --noconfirm --needed
 pacman -S volumeicon --noconfirm --needed
 pacman -S playerctl --noconfirm --needed
 echo -e " ${b}Sound Software${enda} Was Successfully Installed"
 echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
 echo
 read input
}

# Install Printer Management
function installprint {
 echo
 echo -e " Currently Installing ${b}Printer Management${enda}"
 echo && echo -en " ${y}Press Enter To Continue${endc}"
 read input
 echo -e " Installing ${b}Printer Management${enda}"
 pacman -S --noconfirm --needed cups cups-pdf
 pacman -S ghostscript gsfonts gutenprint --noconfirm --needed
 pacman -S gtk3-print-backends --noconfirm --needed
 pacman -S libcups --noconfirm --needed
 pacman -S hplip --noconfirm --needed
 pacman -S system-config-printer --noconfirm --needed

 systemctl enable org.cups.cupsd.service
 echo -e " ${b}Printer Management${enda} Was Successfully Installed"
 echo "After rebooting it will work"
 echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
 echo
 read input
}

# Install Foomatic
function installfoomatic {
 #first try if you can print without foomatic
 echo
 echo -e " Currently Installing ${b}Foomatic${enda}"
 echo && echo -en " ${y}Press Enter To Continue${endc}"
 read input
 echo -e " Installing ${b}Foomatic${enda}"
 pacman -S foomatic-db-engine --noconfirm --needed
 pacman -S foomatic-db foomatic-db-ppds foomatic-db-nonfree-ppds foomatic-db-gutenprint-ppds --noconfirm --needed
 echo -e " ${b}Foomatic${enda} Was Successfully Installed"
 echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
 echo
 read input
}

# Install Samba
function installsamba {
 echo
 echo -e " Currently Installing ${b}Samba${enda}"
 echo && echo -en " ${y}Press Enter To Continue${endc}"
 read input
 echo -e " Installing ${b}Samba${enda}"
 pacman -S --noconfirm --needed samba
 wget "https://git.samba.org/samba.git/?p=samba.git;a=blob_plain;f=examples/smb.conf.default;hb=HEAD" -O /etc/samba/smb.conf.original
 wget "https://raw.githubusercontent.com/arcolinux/arcolinux-system-config/master/etc/samba/smb.conf.arcolinux" -O /etc/samba/smb.conf.arcolinux
 wget "https://raw.githubusercontent.com/arcolinux/arcolinux-system-config/master/etc/samba/smb.conf.arcolinux" -O /etc/samba/smb.conf
 systemctl enable smb.service
 systemctl start smb.service
 systemctl enable nmb.service
 systemctl start nmb.service

 ##Change your username here
 read -p "What is your login? It will be used to add this user to smb : " choice
 smbpasswd -a $choice

 #access samba share windows
 pacman -S --noconfirm --needed gvfs-smb
 echo -e " ${b}Samba${enda} Was Successfully Installed"
 echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
 echo
 read input
}

function installarchrepo {
 # software from standard Arch Linux repositories
 # Core, Extra, Community, Multilib repositories
 echo
 echo -e " Currently Installing ${b}Software from the Standard Arch Linux Repositories${enda}"
 echo && echo -en " ${y}Press Enter To Continue${endc}"
 read input
 echo -e " Installing ${b}Software from the Standard Arch Linux Repositories${enda}"
 echo -e "Installing category ${b}Accessories${enda}"
 
 pacman -S --noconfirm --needed catfish cmatrix galculator gnome-screenshot plank xfburn variety

 echo -e "Installing category ${b}Development${enda}"  

 pacman -S --noconfirm --needed atom geany meld

 echo -e "Installing category ${b}Games${enda}"

 pacman -S --noconfirm --needed kmines steam-native-runtime steam supertuxkart wesnoth

 echo -e "Installing category ${b}Graphics${enda}"

 pacman -S --noconfirm --needed gimp gnome-font-viewer gpick inkscape nomacs ristretto

 echo -e "Installing category ${b}Internet{enda}"

 pacman -S --noconfirm --needed firefox hexchat qbittorrent telegram-desktop

 echo -e "Installing category ${b}Multimedia{enda}"

 pacman -S --noconfirm --needed pragha simplescreenrecorder vlc
 
 package=ncmpcpp
 if pacman -Qi $package &> /dev/null; then

		echo -e $package" is already installed"

 else

    #mpd is the music player daemon
    #it will scan for music and server music to its clients
    #https://wiki.archlinux.org/index.php/Music_Player_Daemon

    pacman -S mpd --noconfirm --needed
    pacman -S mpc --noconfirm --needed

    # no double config allowed in here and in ~/.config
    rm /etc/mpd.conf

    mkdir -p ~/.config/mpd

    cp /usr/share/doc/mpd/mpdconf.example ~/.config/mpd/mpd.conf

    sed -i 's/#music_directory/music_directory/g' ~/.config/mpd/mpd.conf
    sed -i 's/~\/music/~\/Music/g' ~/.config/mpd/mpd.conf

    sed -i 's/#playlist_directory/playlist_directory/g' ~/.config/mpd/mpd.conf
    sed -i 's/~\/.mpd\/playlists/~\/.config\/mpd\/playlists/g' ~/.config/mpd/mpd.conf


    sed -i 's/#db_file/db_file/g' ~/.config/mpd/mpd.conf
    sed -i 's/~\/.mpd\/database/~\/.config\/mpd\/database/g' ~/.config/mpd/mpd.conf

    sed -i 's/#log_file/log_file/g' ~/.config/mpd/mpd.conf
    sed -i 's/~\/.mpd\/log/~\/.config\/mpd\/log/g' ~/.config/mpd/mpd.conf

    sed -i 's/#pid_file/pid_file/g' ~/.config/mpd/mpd.conf
    sed -i 's/~\/.mpd\/pid/~\/.config\/mpd\/pid/g' ~/.config/mpd/mpd.conf

    sed -i 's/#state_file/state_file/g' ~/.config/mpd/mpd.conf
    sed -i 's/~\/.mpd\/state/~\/.config\/mpd\/state/g' ~/.config/mpd/mpd.conf

    sed -i 's/#sticker_file/sticker_file/g' ~/.config/mpd/mpd.conf
    sed -i 's/~\/.mpd\/sticker/~\/.config\/mpd\/sticker/g' ~/.config/mpd/mpd.conf

    sed -i 's/#bind_to_address/bind_to_address/g' ~/.config/mpd/mpd.conf

    sed -i 's/#port/port/g' ~/.config/mpd/mpd.conf

    sed -i 's/#auto_update/auto_update/g' ~/.config/mpd/mpd.conf

    sed -i 's/#follow_inside_symlinks/follow_inside_symlinks/g' ~/.config/mpd/mpd.conf

    sed -i 's/~\/.mpd\/socket/~\/.config\/mpd\/socket/g' ~/.config/mpd/mpd.conf

    sed -i 's/#filesystem_charset/filesystem_charset/g' ~/.config/mpd/mpd.conf

    echo 'audio_output {
          type  "alsa"
          name  "mpd-alsa"
          mixer_type "software"
    }
    audio_output {
    type               "fifo"
    name               "toggle_visualizer"
    path               "/tmp/mpd.fifo"
    format             "44100:16:2"
    }' >> ~/.config/mpd/mpd.conf


    mkdir ~/.config/mpd/playlists

    systemctl --user enable mpd.service
    systemctl --user start mpd.service

    # more info @ https://wiki.archlinux.org/index.php/ncmpcpp

    pacman -S ncmpcpp --noconfirm --needed

    mkdir ~/.ncmpcpp
    cp /usr/share/doc/ncmpcpp/config ~/.ncmpcpp/config

    sed -i 's/#mpd_host/mpd_host/g' ~/.ncmpcpp/config
    sed -i 's/#mpd_port/mpd_port/g' ~/.ncmpcpp/config
    sed -i 's/#mpd_music_dir = ~\/music/mpd_music_dir = ~\/Music/g' ~/.ncmpcpp/config


    cp /usr/share/doc/ncmpcpp/bindings ~/.ncmpcpp/bindings
 fi

 echo -e "Installing category ${b}Office{enda}"

 pacman -S --noconfirm --needed evince libreoffice-fresh thunderbird

 echo -e "Installing category ${b}System${enda}"

 pacman -S --noconfirm --needed arc-gtk-theme accountservice baobab curl dconf-editor dmidecode ffmpegthumbnailer git glances
 pacman -S --noconfirm --needed gnome-disk-utility gnome-keyring gparted grsync gtk-engine-murrine gvfs gvfs-mtp hardinfo hddtemp
 pacman -S --noconfirm --needed htop kvantum-qt5 kvantum-theme-arc lm_sensors lsb-release mlocate net-tools noto-fonts numlocks
 pacman -S --noconfirm --needed polkit-gnome qt5ct sane screenfetch scrot simple-scan sysstat termite
 pacman -S --noconfirm --needed thunar thunar-archive-plugin thunar-volman ttf-ubuntu-font-family ttf-droid tumbler vnstat wget
 pacman -S --noconfirm --needed wmctrl unclutter rxvt-unicode urxvt-perls xdg-user-dirs zenity
 pacman -S --needed --noconfirm virtualbox-host-modules-arch
 pacman -S --noconfirm --needed virtualbox
 grub-mkconfig -o /boot/grub/grub.cfg
 pacman -S --noconfirm --needed dmenu imagemagick w3m xfce4-notifyd

 echo -e "Installing category ${b}Zippers and Unsippers${enda}"

 pacman -S --noconfirm --needed unace unrar zip unzip sharutils  uudeview  arj cabextract file-roller

 echo -e " ${b}Arch Linux Repositories Software${enda} Was Successfully Installed"
 echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
 echo
 read input
}

function installaurrepos {
 echo
 echo -e " Currently Installing ${b}Software from the Arch User Repositories${enda}"
 echo && echo -en " ${y}Press Enter To Continue${endc}"
 read input
 echo -e " Installing ${b}Software from the Auch User Repositories${enda}"
 echo -e "Installing category ${b}Accessories${enda}"
 package="conky-lua-archers"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 package="cool-retro-term"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 package="python2-pyparted"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 package="mintstick-git"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 echo -e "Installing category ${b}Development${enda}"
 package="sublime-text-dev"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 echo -e "Installing category ${b}Internet${enda}"
 package="vivaldi"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 package="vivaldi-codecs-ffmpeg-extra-bin"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 echo -e "Installing category ${b}Multimedia${enda}"
 package="gradio"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 package="peek"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 package="radiotray"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
  echo -e "Installing category ${b}System${enda}"
 package="downgrade"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 package="inxi"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 package="neofetch"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 package="numix-circle-icon-theme-git"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 package="oxy-neon"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 package="pamac-aur"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 package="sardi-icons"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 count=0
 echo -e "Github "$count
 package="sardi-orb-colora-variations-icons-git"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 count=$[count+1]
 echo -e "Github "$count
 package="sardi-orb-colora-mixing-icons-git"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 count=$[count+1]
 echo -e "Github "$count
 package="sardi-mono-papirus-colora-variations-icons-git"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 count=$[count+1]
 echo -e "Github "$count
 package="sardi-mono-numix-colora-variations-icons-git"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 count=$[count+1]
 echo -e "Github "$count
 package="sardi-mono-mixing-icons-git"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 count=$[count+1]
 echo "Github "$count
 package="sardi-mono-colora-variations-icons-git"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 count=$[count+1]
 echo "Github "$count
 package="sardi-mixing-icons-git"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 count=$[count+1]
 echo "Github "$count
 package="sardi-ghost-flexible-variations-icons-git"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 count=$[count+1]
 echo "Github "$count
 package="sardi-ghost-flexible-mixing-icons-git"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 count=$[count+1]
 echo "Github "$count
 package="sardi-ghost-flexible-colora-variations-icons-git"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 count=$[count+1]
 echo "Github "$count
 package="sardi-flexible-variations-icons-git"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 count=$[count+1]
 echo "Github "$count
 package="sardi-flexible-mixing-icons-git"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 count=$[count+1]
 echo "Github "$count
 package="sardi-flexible-luv-colora-variations-icons-git"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 count=$[count+1]
 echo "Github "$count
 package="sardi-flexible-colora-variations-icons-git"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 count=$[count+1]
 echo "Github "$count
 package="sardi-flat-mixing-icons-git"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 count=$[count+1]
 echo "Github "$count
 package="sardi-flat-colora-variations-icons-git"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 count=$[count+1]
 echo "Github "$count
 package="sardi-colora-variations-icons-git"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 package="screenkey-git"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
  package="surfn-icons-git"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
  package="the_platinum_searcher-bin"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
  package="ttf-font-awesome"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
  package="ttf-mac-fonts"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
  package="xcursor-breeze"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 package="hardcode-fixer-git"
 #checking if application is already installed or else install with aur helpers
 if pacman -Qi $package &> /dev/null; then
		echo $package" is already installed"
 else
	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then
		echo "Installing with yay"
		yay -S --noconfirm $package
	else pacman -Qi trizen &> /dev/null; then
		echo "Installing with trizen"
		trizen -S --noconfirm --needed --noedit $package
	fi
	# Check if installation was successful
	if pacman -Qi $package &> /dev/null; then
		echo $package" has been installed"
	else
		echo "${r}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed  !!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${endc}"
	fi
 fi
 hardcode-fixer
 echo -e " ${b}Arch User Repositories Software${enda} Was Successfully Installed"
 echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
 echo
 read input
}


######### Programs Installations : END : ##########################
#################################################################################################
#######################################3RD PART##################################################
function showfirst {
 showlogo
 echo -e " ${b}[ Preliminary Install Items ]${enda}"
 echo -e "Make A Choice 
        1)    Add Keyservers
        2)    Add Trust Keys
        3)    Add Arcolinux Repositories
        4)    Add Software Used in .bashrc
        ----------------------------------
        q)    Return To R00T MENU"
 echo
 echo -en " Choose An Option: "
 read option
 case $option in
 1) installdesktop  ;;
 2) addkeyserver  ;;
 3) addarcolinux  ;;
 4) addbash  ;;
 q) sleep 1 ;;
 *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showdesktop ;;
 esac
}

function showdesktop {
  showlogo
  echo -e " ${b}[ Desktop ]${enda}"
  echo -e "Make A Choice 
        1)    Install Desktop
        -------------------------
        q)    Return To R00T MENU"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installdesktop  ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showdesktop ;;
  esac
}

function showsound {
  showlogo
  echo -e " ${b}[ Sound Software ]${enda}"
  echo -e "Make A Choice
        1)    Install Sound Software
        ----------------------------
        q)    Return To R00T MENU"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installsound  ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showsound ;;
  esac
}

function showprint {
  showlogo
  echo -e " ${b}[ Printer Management ]${enda}"
  echo -e "Make A Choice
        1)    Install Print Management Software
        2)    Install Foomatic *If no printing after installing 1*
        ----------------------------------------------------------
        q)    Return To R00T MENU"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installprint  ;;
  2) installfoomatic ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showprint ;;
  esac
}


# Infinite Loop To Show Menu Untill Exit
while :
do
showlogo
echo -e " ${b}[ R00T MENU ]${enda}"
echo -e "Make A Choice
        1)    Preliminary
        2)    Desktop
        3)    Sound Software
        4)    Printer Managers
        5)    VPN clients
        6)    Chat Applications
        7)    Image Editors
        8)    Video editors/Record
        9)    Archive Handlers
       10)    Audio Applications
       11)    Other Applications
       12)    Development Environments
       13)    Browser/Web Plugins
       14)    Dotfiles
       15)    Usefull Links
      ------------------------
        a)    About ArchXI Script
        q)    Leave ArchXI Script"
echo
echo -en " Choose An Option: "
read option
case $option in
1) showfirst ;;
2) showdesktop ;;
3) showsound ;;
4) showprint ;;
5) showvpn ;;
6) showchat ;;
7) showimg ;;
8) showvid ;;
9) showarch ;;
10) showaudio ;;
11) showothapps ;;
12) showdevapps ;;
13) showwebapps ;;
14) archconfigs ;;
15) showlinks ;;
q) archxiexit ;;
*) echo " \"$option\" Is Not A Valid Option"; sleep 1 ;;

esac


# Exit ArchXI
function archxiexit {
  showlogo && echo -e " Thank You For Using ${b} Arch XFCE Installer Script ${enda}"
  echo
  sleep 1
  clear
  exit
}

done
# End