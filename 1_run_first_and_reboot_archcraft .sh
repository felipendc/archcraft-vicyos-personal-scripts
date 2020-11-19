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

update(){
# Sync and refresh pacman database and update the all of the packages
sudo pacman -Syyu --noconfirm
yay -Syu --noconfirm
}

personal_pkgs(){
###### Pacman ########

# fix timezone:
sudo pacman -S chrony --noconfirm

# Davinci Resolve fix:
sudo pacman -S ocl-icd --noconfirm

sudo pacman -S gnome-system-monitor --noconfirm
sudo pacman -S playerctl --noconfirm
sudo pacman -S gimp --noconfirm
sudo pacman -S inkscape --noconfirm
sudo pacman -S qbittorrent --noconfirm
sudo pacman -S vlc --noconfirm
sudo pacman -S youtube-dl --noconfirm
sudo pacman -S clementine --noconfirm
sudo pacman -S krita --noconfirm
sudo pacman -S gnome-calculator --noconfirm
sudo pacman -S clipgrab --noconfirm
sudo pacman -S pinta --noconfirm
sudo pacman -S filezilla --noconfirm
sudo pacman -S python-pip  --noconfirm
sudo pacman -S curl --noconfirm
sudo pacman -S simple-scan --noconfirm
sudo pacman -S arandr --noconfirm
sudo pacman -S hwinfo --noconfirm
sudo pacman -S firefox --noconfirm
sudo pacman -S adb --noconfirm
sudo pacman -S gnome-disk-utility --noconfirm

###### Trizen Dependencies ######
sudo pacman -S git --noconfirm
sudo pacman -S pacutils --noconfirm
sudo pacman -S perl>=5.20.0 --noconfirm
sudo pacman -S perl-libwww --noconfirm
sudo pacman -S perl-term-ui --noconfirm
sudo pacman -S pacman --noconfirm
sudo pacman -S perl-json --noconfirm
sudo pacman -S perl-data-dump --noconfirm
sudo pacman -S perl-lwp-protocol-https --noconfirm
sudo pacman -S perl-term-readline-gnu --noconfirm
sudo pacman -S hplip --noconfirm

###### Trizen #######

# Hplib Gui: 
trizen -S python-pyqt5 --needed --noconfirm

trizen -S wget --needed --noconfirm
trizen -S redshiftgui-bin --needed --noconfirm
trizen -S python --needed --noconfirm
trizen -S google-chrome --needed --noconfirm
trizen -S visual-studio-code-bin --needed --noconfirm
trizen -S android-studio --needed --noconfirm
trizen -S onlyoffice-bin --needed --noconfirm
trizen -S kdenlive --needed --noconfirm
}

reboot_os(){
sudo reboot
}


loading_banner
update
trizen
personal_pkgs
reboot_os