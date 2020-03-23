#!/bin/bash
# credit  :  Erik Dubois
# https://github.com/arcolinuxd/arco-xfce
set -e
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

sudo pacman -S cups cups-pdf ghostscript gsfonts gutenprint gtk3-print-backends libcups hplip system-config-printer --noconfirm --needed

sudo systemctl enable org.cups.cupsd.service

echo "################################################################"
echo "#########   printer management software installed     ##########"
echo "#########               PLEASE REBOOT                 ##########"
echo "################################################################"
