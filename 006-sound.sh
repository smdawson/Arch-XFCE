#!/bin/bash
# credit  :  Erik Dubois
# https://github.com/arcolinuxd/arco-xfce
set -e
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

#Sound
sudo pacman -S pulseaudio pulseaudio-alsa pavucontrol alsa-utils alsa-plugins alsa-lib alsa-firmware gstreamer gst-plugins-good gst-plugins-bad gst-plugins-base gst-plugins-ugly volumeicon playerctl --noconfirm --needed

echo "################################################################"
echo "#########   sound software software installed   ################"
echo "################################################################"
