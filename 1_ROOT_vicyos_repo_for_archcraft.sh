#!/bin/bash

printf "\033c"

echo "##################################################################"
echo "######  Make sure you are executing this script as ROOT  #########"
echo "###### Example:  sudo ./1_ROOT_vicyos_repo_for_archcraft.sh  #####"
echo "##################################################################"
sleep 7
printf "\033c"

# Import vicyos_setup_banner.sh
source ./needed_files/vicyos_banner/vicyos_setup_banner.sh

###########################################################################
# Written to be used on my Thinkpad T430 or Desktop with Archcraft Linux. #
# Desktop Environment   :   Openbox                                       #
# Author                :   Vicyos (felipendc)                            #
# My Github             :   github.com/felipendc                          #
# Important Note        :   I use Arch! btw... Hahaha!                    #
###########################################################################


update () {
# Sync and refresh pacman database and update the all of the packages
sudo pacman -Syy && sudo pacman -Syu --noconfirm
yay -Syu --noconfirm

sudo pacman -S archlinux-keyring
sudo pacman-key --populate
}

vicyos_repo () {
# Append vicyos repo
cat >> /etc/pacman.conf <<- _EOF_

	## Vicyos Repository
	[v_twenty_repo]
	SigLevel = Optional TrustedOnly 
	Server = https://felipendc.github.io/\$repo/\$arch
	_EOF_
	
	# Refresh the database and the repository
	sudo pacman -Syyu
}

add_vicyos_repo () {
# Check if Vicyos repository already exists. 
# If it's missing, add it to the pacman.config file.
repo_get_line=$(grep -E "(v_twenty_repo)" /etc/pacman.conf)
repo_vicyos_line="[v_twenty_repo]"

if [ "$repo_get_line" == "$repo_vicyos_line" ]; then
    echo "Vicyos repository already exists."
else
	# Add vicyos-repo
	vicyos_repo
	echo "Vicyos repository was added successfully."
fi
}


loading_banner
add_vicyos_repo 
