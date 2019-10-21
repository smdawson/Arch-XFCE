#!/bin/bash
set -e
#
##########################################################
#                 Arch-XFCE script                       #
#  ArchLinux Applications Automatic Installation Script  #
#  Inspired and Forked From                              #
#  https://github.com/SofianeHamlaoui/ArchI0             #
#  And                                                   #
#  https://github.com/arcolinuxd/arco-xfce               #
##########################################################
#  +FIRST  : sudo chmod +x archxi.sh                     #
#                (Give EXEC Access To Script)            #
#  +TO RUN    : ./arcxi.sh                               #
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
version="20191021"

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

# Initial pacman -Syu
function initpacmanupd {
  echo 
  echo -e "${b} Updating ..... ${enda}"
  echo
  sudo pacman -Syyu --noconfirm
  echo "Update Completed" 
  echo
  sleep 5
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
sleep 5
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
sleep 5
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
sleep 5
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
sleep 5
} 

#Add Key Servers
function addkeyservers {

 echo -e " ${b}[!]::[please wait]:  Adding keyservers to personal .gpg for future applications...${enda}"
 echo

 [ -d $HOME"/.gnupg" ] || mkdir -p $HOME"/.gnupg"

 echo '
 keyserver hkp://pool.sks-keyservers.net:80
 keyserver hkps://hkps.pool.sks-keyservers.net:443
 keyserver hkp://ipv4.pool.sks-keyservers.net:11371' | tee --append ~/.gnupg/gpg.conf

 chmod 600 ~/.gnupg/gpg.conf
 chmod 700 ~/.gnupg

 echo -e " ${b}[!]::[please wait]:  Adding keyservers to the /etc/pacman.d/gnupg folder for the use with pacman...${enda}"
 echo

 echo '
 keyserver hkp://pool.sks-keyservers.net:80
 keyserver hkps://hkps.pool.sks-keyservers.net:443
 keyserver hkp://ipv4.pool.sks-keyservers.net:11371' | sudo tee --append /etc/pacman.d/gnupg/gpg.conf

 echo -e " [${g}✔${endc}]::[${b}Keyservers${enda}] Added"
 echo
 sleep 5
}

# Add Trust Key
function trustkey {
 echo -e " ${b}[!]::[please wait]: Receiving, local signing and refreshing keys...${enda}"

 sudo pacman-key -r 74F5DE85A506BF64
 sudo pacman-key --lsign-key 74F5DE85A506BF64
 sudo pacman-key --refresh-keys

 echo -e " [${g}✔${endc}]::[${b}Key Trusted${enda}] "
 sleep 5
}

# Add Arcolinux Repos
function arcolinuxrepos {
 echo -e " ${b}[!]::[please wait]:  Getting the Latest Arcolunux Mirrors File...${enda}"

 sudo wget https://raw.githubusercontent.com/arcolinux/arcolinux-mirrorlist/master/etc/pacman.d/arcolinux-mirrorlist -O /etc/pacman.d/arcolinux-mirrorlist


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

 sudo pacman -Syy

 echo "Installing the official mirrorlist file now."

 sudo pacman -S arcolinux-mirrorlist-git --noconfirm

 echo -e " [${g}✔${endc}]::[${b}Arcolunux Repo's Added${enda}] "
 sleep 5
}
function aurinstall {
	#----------------------------------------------------------------------------------
	# Check If Package Is Installed
	if pacman -Qi $package &> /dev/null; then
			echo -e " [${g}✔${endc}]::[${b}"$package"${enda}] Is Already Installed!"
	else
		yay -S --noconfirm $package
		# Verify Successful Installation
		if pacman -Qi $package &> /dev/null; then
			echo -e " [${g}✔${endc}]::[${b}"$package"${enda}]: Installed!"
		else
			echo -e " [${r}!${endc}]::[${b}"$package"${enda}]: ${r}NOT Installed!${endc}"
		fi
	fi
}
showlogo
initpacmanupd
checkyay
checktrizen
checkgit
checkwget
addkeyservers
addtrustkey
aroclinuxrepos
initpacmanupd

# Install software used in .bashrc
echo -e " ${b}[!]::[please wait]:  Installing Software used in .bashrc...${enda}"
echo
sudo pacman -S --noconfirm --needed expac hwinfo reflector youtube-dl
echo -e " [${g}✔${endc}]::[${b}.bashrc Software${enda}]: Installed!"
echo
sleep 5

# Install Display Manager and Desktop
echo -e " ${b}[!]::[please wait]:  Installing Display Manager and XFCE Desktop...${enda}"
echo
#installing displaymanager or login manager
sudo pacman -S --noconfirm --needed lightdm arcolinux-lightdm-gtk-greeter arcolinux-lightdm-gtk-greeter-settings arcolinux-wallpapers-git  
#installing desktop environment
sudo pacman -S --noconfirm --needed xfce4 xfce4-goodies
#enabling displaymanager or login manager
sudo systemctl enable lightdm.service -f
sudo systemctl set-default graphical.target
#Remove xfce4 artwork
sudo pacman -R xfce4-artwork --noconfirm
echo -e " [${g}✔${endc}]::[${b}Display Manager and XFCE Desktop${enda}]: Installed!"
echo
sleep 5

# Install Sound Software
echo -e " ${b}[!]::[please wait]:  Installing Display Sound Software...${enda}"
echo
sudo pacman -S --noconfirm --needed pulseaudio pulseaudio-alsa pavucontrol alsa-utils alsa-plugins alsa-lib alsa-firmware
sudo pacman -S --noconfirm --needed gstreamer gst-plugins-good gst-plugins-bad gst-plugins-base gst-plugins-ugly
sudo pacman -S --noconfirm --needed volumeicon playerctl
echo -e " [${g}✔${endc}]::[${b}Sound Software${enda}]: Installed!"
echo
sleep 5

# Install Printer Management
echo -e " ${b}[!]::[please wait]:  Installing Print Management Software...${enda}"
echo
sudo pacman -S --noconfirm --needed cups cups-pdf ghostscript gsfonts gutenprint gtk3-print-backends libcups hplip system-config-printer
sudo systemctl enable org.cups.cupsd.service
echo -e " [${g}✔${endc}]::[${b}Print Management Software${enda}]: Installed!"
echo
sleep 5

# Install Samba
echo -e " ${b}[!]::[please wait]:  Installing Samba...${enda}"
echo
sudo pacman -S --noconfirm --needed samba
sudo wget "https://git.samba.org/samba.git/?p=samba.git;a=blob_plain;f=examples/smb.conf.default;hb=HEAD" -O /etc/samba/smb.conf.original
#sudo wget "https://raw.githubusercontent.com/arcolinux/arcolinux-system-config/master/etc/samba/smb.conf.arcolinux" -O /etc/samba/smb.conf.arcolinux
sudo wget "https://raw.githubusercontent.com/arcolinux/arcolinux-system-config/master/etc/samba/smb.conf.arcolinux" -O /etc/samba/smb.conf
sudo systemctl enable smb.service
sudo systemctl start smb.service
sudo systemctl enable nmb.service
sudo systemctl start nmb.service
##Change your username here
read -p "What is your login? It will be used to add this user to smb : " choice
sudo smbpasswd -a $choice
#access samba share windows
sudo pacman -S --noconfirm --needed gvfs-smb
echo -e " [${g}✔${endc}]::[${b}Samba${enda}]: Installed!"
echo
sleep 5

# software from standard Arch Linux repositories
# Core, Extra, Community, Multilib repositories
echo -e " ${b}Installing Software From Standard Arch Linux Repositories${enda}"
echo
echo -e " ${b}[!]::[please wait]:  Installing Accessories Category...${enda}"
echo
sudo pacman -S --noconfirm --needed catfish cmatrix galculator gnome-screenshot plank xfburn variety
echo -e " [${g}✔${endc}]::[${b}Accessories Category${enda}]: Installed!"
echo
echo -e " ${b}[!]::[please wait]:  Installing Development Category...${enda}"
echo
sudo pacman -S --noconfirm --needed atom geany meld
echo -e " [${g}✔${endc}]::[${b}Accessories Category${enda}]: Installed!"
echo
echo -e " ${b}[!]::[please wait]:  Installing Games Category...${enda}"
echo
sudo pacman -S --noconfirm --needed kmines steam-native-runtime steam supertuxkart wesnoth
echo -e " [${g}✔${endc}]::[${b}Games Category${enda}]: Installed!"
echo
echo -e " ${b}[!]::[please wait]:  Installing Graphics Category...${enda}"
echo
sudo pacman -S --noconfirm --needed gimp gnome-font-viewer gpick inkscape nomacs ristretto
echo -e " [${g}✔${endc}]::[${b}Graphics Category${enda}]: Installed!"
echo
echo -e " ${b}[!]::[please wait]:  Installing Internet Category...${enda}"
echo
sudo pacman -S --noconfirm --needed firefox hexchat qbittorrent telegram-desktop
echo -e " [${g}✔${endc}]::[${b}Internet Category${enda}]: Installed!"
echo
echo -e " ${b}[!]::[please wait]:  Installing Multimedia Category...${enda}"
echo
sudo pacman -S --noconfirm --needed pragha simplescreenrecorder vlc
echo -e " [${g}✔${endc}]::[${b}Multimedia Category${enda}]: Installed!"
echo
echo -e " ${b}[!]::[please wait]:  Installing Offce Category...${enda}"
echo
sudo pacman -S --noconfirm --needed evince libreoffice-fresh thunderbird
echo -e " [${g}✔${endc}]::[${b}Office Category${enda}]: Installed!"
echo
echo -e " ${b}[!]::[please wait]:  Installing System Category...${enda}"
echo
sudo pacman -S --noconfirm --needed arc-gtk-theme accountsservice baobab curl dconf-editor dmenu dmidecode ffmpegthumbnailer git glances gnome-disk-utility gnome-keyring
sudo pacman -S --noconfirm --needed gparted grsync gtk-engine-murrine gvfs gvfs-mtp hardinfo hddtemp htop imagemagick kvantum-qt5 kvantum-theme-arc lm_sensors lsb-release mlocate
sudo pacman -S --noconfirm --needed net-tools noto-fonts numlockx polkit-gnome qt5ct rxvt-unicode sane screenfetch scrot simple-scan sysstat termite thunar thunar-archive-plugin thunar-volman
sudo pacman -S --noconfirm --needed ttf-ubuntu-font-family ttf-droid tumbler vnstat wmctrl unclutter urxvt-perls w3m xclip xdg-user-dirs xfce4-notifyd zenity
echo -e " [${g}✔${endc}]::[${b}System Category${enda}]: Installed!"
echo
echo -e " ${b}[!]::[please wait]:  Installing Zippers and Unzippers...${enda}"
echo
sudo pacman -S --noconfirm --needed unace unrar zip unzip sharutils  uudeview  arj cabextract file-roller
echo -e " [${g}✔${endc}]::[${b}Zippers and Unzippers${enda}]: Installed!"
echo
echo -e " [${g}✔${endc}]::[${b}Software From Standard Arch Linux Repo${enda}]: Installed!"
echo
sleep 5
# software from AUR (Arch User Repositories)
# https://aur.archlinux.org/packages/
echo -e " ${b}Installing Software From Arch User Repositories (AUR)${enda}"
echo
echo -e " ${b}[!]::[please wait]:  Installing Accessories Category...${enda}"
echo

package="bitwarden-bin"
aurinstall

package="conky-lua-archers"
aurinstall

package="cool-retro-term"
aurinstall

package="python2-pyparted"
aurinstall

package="mintstick-git"
aurinstall

echo -e " [${g}✔${endc}]::[${b}Accessories Category${enda}]: Installed!"
echo
echo -e " ${b}[!]::[please wait]:  Installing Development Category...${enda}"
echo

package="sublime-text-dev"
aurinstall

echo -e " [${g}✔${endc}]::[${b}Development Category${enda}]: Installed!"
echo

echo -e " ${b}[!]::[please wait]:  Installing Multimedia Category...${enda}"
echo

package="gradio"
aurinstall

package=ncmpcpp
if pacman -Qi $package &> /dev/null; then
		echo -e " [${g}✔${endc}]::[${b}"$Package"${enda}] Is Already Installed!"
else
    sudo pacman -S mpd --noconfirm --needed
    sudo pacman -S mpc --noconfirm --needed
    sudo rm /etc/mpd.conf
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
    sudo pacman -S ncmpcpp --noconfirm --needed
    mkdir ~/.ncmpcpp
    cp /usr/share/doc/ncmpcpp/config ~/.ncmpcpp/config
    sed -i 's/#mpd_host/mpd_host/g' ~/.ncmpcpp/config
    sed -i 's/#mpd_port/mpd_port/g' ~/.ncmpcpp/config
    sed -i 's/#mpd_music_dir = ~\/music/mpd_music_dir = ~\/Music/g' ~/.ncmpcpp/config
    cp /usr/share/doc/ncmpcpp/bindings ~/.ncmpcpp/bindings
fi

package="radiotray"
aurinstall

echo -e " [${g}✔${endc}]::[${b}Multimedia Category${enda}]: Installed!"
echo
echo -e " ${b}[!]::[please wait]:  Installing System Category...${enda}"
echo

package="downgrade"
aurinstall

package="inxi"
aurinstall

package="menulibre"
aurinstall

package="mugshot"
aurinstall

package="neofetch"
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

package="ttf-font-awesome"
aurinstall

package="ttf-mac-fonts"
aurinstall

sudo pacman -S --noconfirm --needed virtualbox virtualbox-host-dkms linux-lts-headers
sudo grub-mkconfig -o /boot/grub/grub.cfg
echo -e " [${g}✔${endc}]::[${b}Virtualbox For Linux${enda}]: Installed!"

package="xcursor-breeze"
aurinstall

package="xfce4-panel-profiles"
aurinstall

package="yad"
aurinstall

echo -e " [${g}✔${endc}]::[${b}System Category${enda}]: Installed!"
echo
echo -e " ${b}[!]::[please wait]:  Installing Hardcode-Fixer...${enda}"
echo

package="hardcode-fixer-git"
aurinstall

echo -e " [${g}✔${endc}]::[${b}Software From Arch User Repositories(AUR)${enda}]: Installed!"
echo
sleep 5
echo -e " ${b}Installing Software From ArcoLinux Repositories${enda}"

sudo pacman -S --noconfirm --needed arcolinux-applications-git arcolinux-arc-themes-nico-git arcolinux-bin-git arcolinux-config-git
sudo pacman -S --noconfirm --needed arcolinux-conky-collection-git arcolinux-faces-git arcolinux-fonts-git arcolinux-geany-git arcolinux-kvantum-git
sudo pacman -S --noconfirm --needed arcolinux-lightdm-gtk-greeter arcolinux-lightdm-gtk-greeter-settings arcolinux-local-git arcolinux-mirrorlist-git
sudo pacman -S --noconfirm --needed arcolinux-nitrogen-git arcolinux-pipemenus-git arcolinux-plank-git arcolinux-plank-themes-git
sudo pacman -S --noconfirm --needed arcolinux-qt5-git arcolinux-rofi-git arcolinux-rofi-themes-git arcolinux-root-git arcolinux-slim
sudo pacman -S --noconfirm --needed arcolinux-slimlock-themes-git arcolinux-system-config-git arcolinux-termite-themes-git arcolinux-variety-git arcolinux-wallpapers-git
sudo pacman -S --noconfirm --needed arcolinux-xfce4-panel-profiles-git arcolinux-xfce-thunar-git

echo -e " [${g}✔${endc}]::[${b}Software From ArcoLinux Repositories${enda}]: Installed!"
echo
echo -e " ${b}Copying all files and folders from /etc/skel to ~${enda}"
echo
sudo cp -rT /etc/skel ~

echo -e " ${b}Removing All Unnecessary Folders and Files From .config${enda}"
echo

sudo rm -rf ~/.config/volumeicon

sleep 5
echo -e " ${b}Installing Fonts From Arch Linux Repositories${enda}"
echo

sudo pacman -S --noconfirm --needed adobe-source-sans-pro-fonts cantarell-fonts noto-fonts terminus-font ttf-bitstream-vera ttf-dejavu ttf-droid 
sudo pacman -S --noconfirm --needed ttf-inconsolata ttf-liberation ttf-roboto ttf-ubuntu-font-family tamsyn-font

echo -e " [${g}✔${endc}]::[${b}Software From Arch User Repositories(AUR)${enda}]: Installed!"
echo
sleep 5

echo -e " ${b}Installing Fonts For Conkies${enda}"
echo

[ -d $HOME"/.fonts" ] || mkdir -p $HOME"/.fonts"

echo "Copy fonts to .fonts"

cp fonts/* ~/.fonts/

echo "Building new fonts into the cache files";
echo "Depending on the number of fonts, this may take a while..."
fc-cache -fv ~/.fonts

echo -e " [${g}✔${endc}]::[${b}Fonts For Conkies(AUR)${enda}]: Installed!"
echo
sleep 5
clear
echo -e "${g}"
echo -e "**************************************************************"
echo -e "*                                                            *"
echo -e "*                 Installation Complete!                     *"
echo -e "*         Restart Computer For Changes To Take Effect        *"
echo -e "*                                                            *"
echo -e "**************************************************************${endc}"
