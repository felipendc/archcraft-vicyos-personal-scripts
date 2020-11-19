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

install_trizen(){
# Unpacking file
rm -Rvf trizen
tar -xvf $trizen_file

# Compile trizen, install it, and clean up the temp files
cd trizen
makepkg -s
sudo pacman -U trizen*.zst --noconfirm
cd ../
rm -Rvf trizen
sudo rm -Rv $trizen_file
}

snapshot(){
# It waits 5 secs and then it downloads the trizen snapshot (PKGBUILD file) 
# and self stop after the download is finished!
sleep 5
curl https://aur.archlinux.org/cgit/aur.git/snapshot/trizen.tar.gz --output trizen.tar.gz
}

trizen(){
trizen_file="trizen.tar.gz" 

counter=0
seconds_is=""

# Wait until trizen snapshot is downloaded and trigger the trizen installation function (install_trizen)
if  pacman -Qi trizen &> /dev/null; then
	echo "Trizen is already installed." 
	exit
else
	if [ -e "$trizen_file" ]; then

		# Clean up to avoid any conflicts
		sudo rm -Rv $trizen_file
	
		# It waits for the download to finished!
		snapshot &
	else
		snapshot &
	fi

	#If the trizen file don't exist then, download it
	if [ ! -e "$trizen_file" ]; then

		# Loop through the below commands until trizen_file is downloaded
		# Or wait 120 seconds (2 minutes) and exit the entire script
		until [ -e "$trizen_file" ] 
		do
			# For each second add +1 to the counter variable
			counter=$((counter+1))

			# Verify if the number in "counter" is plural or singular and add it to the "seconds_is" variable
			if [ $counter == 1 ]; then
				seconds_is=" second"
			else
				seconds_is=" seconds"
			fi

			# Wait 1 second
			sleep 1
			if [ -e "$trizen_file" ]; then
				echo "Congrats!!! $trizen_file file was downloaded successfully!"

			elif [ "$counter" == 121 ]; then
				clear
				echo ""
				echo "Download failed! $trizen_file file wasn't downloaded successfully!" 
				echo "Time is out! 120 seconds (2 minutes) went by." 
				echo "Please, check if your internet speed is slow or your connection is working and try again." 
				echo ""
				exit
			else
				echo "Please wait... $trizen_file is being downloaded! $counter$seconds_is"
			fi
		done
	fi
fi

# Wait for each specified process to complete and return its termination status
wait -n

# Call install_trizen function
install_trizen
}

vicyos_polybar_p1(){
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
	cp -r needed_files/vicyos_modified_polybar ~/.config/polybar
	
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


# loading_banner
# reset_color
# add_vicyos_repo 
# trizen
vicyos_polybar_p1
# vicyos_zsh
# update 
