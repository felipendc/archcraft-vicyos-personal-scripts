#!/bin/bash

# Import vicyos_setup_banner.sh
source ./needed_files/vicyos_banner/vicyos_setup_banner.sh

################################################################
# Written to be used on my Thinkpad T430 with Archcraft Linux. #
# Desktop Environment   :   Openbox                            #
# Author                :   Vicyos (felipendc)                 #
# My Github             :   github.com/felipendc               #
# Important Note        :   I use Arch! btw... Hahaha!         #
################################################################


update () {
# Sync and refresh pacman database and update the all of the packages
sudo pacman -Syyu --noconfirm
yay -Syu --noconfirm
}

vicyos_repo () {
# Append vicyos repo
cat >> /etc/pacman.conf <<- _EOF_

	## Vicyos Repository
	[vicyos-repo]
	SigLevel = Optional TrustedOnly 
	Server = https://felipendc.github.io/\$repo/\$arch
	_EOF_
}

add_vicyos_repo () {
# Check if Vicyos repository already exists. 
# If it's missing, add it to the pacman.config file.
repo_get_line=$(grep -E "(vicyos-repo)" /etc/pacman.conf)
repo_vicyos_line="[vicyos-repo]"

if [ "$repo_get_line" == "$repo_vicyos_line" ]; then
    echo "Vicyos repository already exists."
else
	# Add vicyos-repo
	vicyos_repo
	echo "Vicyos repository was added successfully."
fi
}

vicyos_polybar_desktop(){
original_polybar="$HOME/.config/polybar/default_launch.sh"
backup_folder="$HOME/vicyos_backups"

# Check if vicyos Two Polybars are already installed
if [ -e "$original_polybar" ]; then

	echo "Vicyos Polybar for Desktop is already installed"
else
# Make a backup of the polybar folder to "~/vicyos_backups"
	zip polybar_backup.zip -r ~/.config/polybar
	if [ -d "$backup_folder" ]; then
		rm -R $backup_folder
		mkdir $backup_folder
	else
		mkdir $backup_folder
	fi
	mv polybar_backup.zip $backup_folder

	# Make a backup of the autostart file to "~/vicyos_backups"
	# Set the right polybar ".sh" file to autostart
	cp -r ~/.config/openbox/autostart $backup_folder

	# Remove the polybar folder to avoid any conflicts
	# Copy the vicyos modified polybar files to ~/.config/polybar
	rm -R ~/.config/polybar
	cp -r needed_files/vicyos_modified_polybar_desktop ~/.config/polybar
	
	# Delete "autostart" file in "~/.config/openbox/" to avoid any conflicts
	# Copy a modified "autostart" file to "~/.config/openbox/"
	rm -Rvf $HOME/.config/openbox/autostart
	mv $HOME/.config/polybar/autostart $HOME/.config/openbox

	# Make some polybar files executable 
	chmod +x ~/.config/polybar/default_launch.sh
	chmod +x ~/.config/polybar/wave/launch.sh
	chmod +x ~/.config/polybar/spark/launch.sh
	chmod +x ~/.config/polybar/manhattan/launch.sh
	chmod +x ~/.config/polybar/grid/launch.sh
	chmod +x ~/.config/polybar/forest/launch.sh
	chmod +x ~/.config/polybar/default/launch.sh
	chmod +x ~/.config/polybar/beach/launch.sh	
fi
}

vicyos_polybar_laptop(){
original_polybar="$HOME/.config/polybar/vicyos_two_polybars.sh"
backup_folder="$HOME/vicyos_backups"

# Check if vicyos Two Polybars are already installed
if [ -e "$original_polybar" ]; then

	echo "Vicyos Two Polybars are already installed"
else
# Make a backup of the polybar folder to "~/vicyos_backups"
	zip polybar_backup.zip -r ~/.config/polybar
	if [ -d "$backup_folder" ]; then
		rm -R $backup_folder
		mkdir $backup_folder
	else
		mkdir $backup_folder
	fi
	mv polybar_backup.zip $backup_folder

	# Make a backup of the autostart file to "~/vicyos_backups"
	# Set the right polybar ".sh" file to autostart
	cp -r ~/.config/openbox/autostart $backup_folder

	# Remove the polybar folder to avoid any conflicts
	# Copy the vicyos modified polybar files to ~/.config/polybar
	rm -R ~/.config/polybar
	cp -r needed_files/vicyos_modified_polybar_laptop ~/.config/polybar
	
	# Delete "autostart" file in "~/.config/openbox/" to avoid any conflicts
	# Copy a modified "autostart" file to "~/.config/openbox/"
	rm -Rvf $HOME/.config/openbox/autostart
	mv $HOME/.config/polybar/autostart $HOME/.config/openbox

	# Make some polybar files executable 
	chmod +x ~/.config/polybar/default_launch.sh
	chmod +x ~/.config/polybar/vicyos_two_polybars.sh
	chmod +x ~/.config/polybar/wave/launch.sh
	chmod +x ~/.config/polybar/spark/launch.sh
	chmod +x ~/.config/polybar/manhattan/launch.sh
	chmod +x ~/.config/polybar/grid/launch.sh
	chmod +x ~/.config/polybar/forest/launch.sh
	chmod +x ~/.config/polybar/default/launch.sh
	chmod +x ~/.config/polybar/beach/launch.sh	
	chmod +x ~/.config/polybar/vicyos_openbox_two_polybars/secondary_hdmi_launch.sh
	chmod +x ~/.config/polybar/vicyos_openbox_two_polybars/primary_lvds1_launch.sh
fi
}

vicyos_zsh(){
# Check if "vicyos personal zshrc" line exist in "~/.zshrc"
# If this line "vicyos personal zshrc" doesn't exist in "~/.zshrc",
# the "zsh_get_line" variable value will be null
zsh_get_line=$(grep -E "(# vicyos personal zshrc)" $HOME/.zshrc)

# Check if "zsh_get_line" variable is null
if [ -z "$zsh_get_line" ]; then

	# Remove old .zshrc to avoid any conflicts
	# Move vicyos_modified_zshrc to Home folder renamed to .zshrc
	# Refresh .zshrc
	rm -R $HOME/.zshrc
	cp -r needed_files/vicyos_modified_zshrc/vicyos_modified_zshrc $HOME/.zshrc
	source $HOME/.zshrc
	echo "Vicyos personal .zshrc was added successfully."
else
	clear
    echo "Vicyos personal .zshrc already exists."
fi
}

fix_bluetooth(){
# Install bluetooth, enable and start its services!
sh ./needed_files/ArcolinuxD-OpenBox-Scripts/130-bluetooth.sh

# Make bluetooth systemicon visible again!
sh ./needed_files/ArcolinuxD-OpenBox-Scripts/make-bluetooth-systemicon-visible-again.sh
}

printers(){
# Install packages for printer 
sh ./needed_files/ArcolinuxD-OpenBox-Scripts/140-printers.sh
}

snap_apps(){
sudo snap install youtube-music-desktop-app
sudo snap install strimio-desktop
}


choose_installation(){
printf "\033c"
echo
tput setaf 4
echo "################################################################"
echo "#####  Choose wisely - one time setup after clean install   ####"
echo "################################################################"
tput sgr0
echo
echo "Select the correct desktop"
echo
echo "c = Cancel"
echo "d = Desktop"
echo "l = Laptop"

echo "Chose an option..."

read GET_OPTION

case $GET_OPTION in

	c )
		# Cancel the script
		printf "\033c"
		echo
		echo "#######################################"
		echo "####   The script was cancelled    ####"
		echo "#######################################"
		echo
	;;
	d )
		# Setting up files for Desktop
		printf "\033c"
		loading_banner
		add_vicyos_repo 
		fix_bluetooth
		printers
		vicyos_polybar_desktop 
		vicyos_zsh
		snap_apps
		update 
	;;
	l )
		# Setting up files for Laptop
		printf "\033c"
		loading_banner
		add_vicyos_repo 
		fix_bluetooth
		printers
		vicyos_polybar_laptop
		vicyos_zsh
		snap_apps
		update 
	;;
esac
}

choose_installation
