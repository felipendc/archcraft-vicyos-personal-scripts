#!/bin/bash

# Import vicyos_setup_banner.sh
source ./needed_files/vicyos_banner/vicyos_setup_banner.sh

###########################################################################
# Written to be used on my Thinkpad T430 or Desktop with Archcraft Linux. #
# Desktop Environment   :   Openbox                                       #
# Author                :   Vicyos (felipendc)                            #
# My Github             :   github.com/felipendc                          #
# Important Note        :   I use Arch! btw... Hahaha!                    #
###########################################################################

snapd_install(){
# Check if Snapd is already installed
if  pacman -Qi snapd &> /dev/null; then
	echo "Snapd is already installed." 
else
	echo "Installing Snapd." 

	# Clear temp files to avoid any conflicts
	if [ -d "snapd" ]; then
		rm -Rvf snapd
	fi

	# Download and install Snapd
	git clone https://aur.archlinux.org/snapd.git
	cd snapd
	makepkg -si

	# enabled snapd.socket
	sudo systemctl enable --now snapd.socket

	# create a symbolic l
	sudo ln -s /var/lib/snapd/snap /snap
	
	# Clear temp files
	cd ../
	rm -Rvf snapd
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
#	exit
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

update(){
# Sync and refresh pacman database and update the all of the packages

sudo pacman -Syy && sudo pacman -Syu --noconfirm
yay -Syu --noconfirm
}

reboot_os(){
sudo reboot
}

remove_apps(){
# Remove unnecessary apps
sudo pacman -Rdd mplayer --noconfirm

}

loading_banner
remove_apps
update
snapd_install
trizen
reboot_os
