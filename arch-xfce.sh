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

# KAAIS Logo
showlogo () {
  clear
  echo -e "${b}${g}
    :::     :::::::::   ::::::::  :::    :::      :::    ::: :::::::::: ::::::::  :::::::::: 
  :+: :+:   :+:    :+: :+:    :+: :+:    :+:      :+:    :+: :+:       :+:    :+: :+:        
 +:+   +:+  +:+    +:+ +:+        +:+    +:+       +:+  +:+  +:+       +:+        +:+        
+#++:++#++: +#++:++#:  +#+        +#++:++#++        +#++:+   :#::+::#  +#+        +#++:++#   
+#+     +#+ +#+    +#+ +#+        +#+    +#+       +#+  +#+  +#+       +#+        +#+        
#+#     #+# #+#    #+# #+#    #+# #+#    #+#      #+#    #+# #+#       #+#    #+# #+#        
###     ### ###    ###  ########  ###    ###      ###    ### ###        ########  ########## 
                                                                
    ###    ### ###     ### ###     ### #######  ##{v4}##${enda}
"
    echo
}

showlogo
sleep 1