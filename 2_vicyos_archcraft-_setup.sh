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
# Sync and refresh pacman database and update the packages
sudo pacman -Syyu --noconfirm
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

# Wait for each specified process to complete and return its termination status.
wait -n

# call install_trizen function
install_trizen
}

vicyos_polybar(){
original_polybar="$HOME/.config/polybar/launch.sh"
backup_folder="$HOME/vicyos_backups"

if [ -e "$original_polybar" ]; then

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
	sed -i '/sh ~\/.config\/polybar\/launch.sh/c\sh ~\/.config\/polybar\/vicyos_modified_polybar.sh' ~/.config/openbox/autostart
    
	# Remove the polybar folder to avoid any conflicts
	# Copy the vicyos modified polybar files to ~/.config/polybar
	rm -R ~/.config/polybar
	cp -r needed_files/vicyos_modified_polybar ~/.config/polybar

	# Make some polybar files executable
	chmod +x ~/.config/polybar/vicyos_modified_polybar.sh
	chmod +x ~/.config/polybar/wave/launch.sh
	chmod +x ~/.config/polybar/spark/launch.sh
	chmod +x ~/.config/polybar/manhattan/launch.sh
	chmod +x ~/.config/polybar/grid/launch.sh
	chmod +x ~/.config/polybar/forest/launch.sh
	chmod +x ~/.config/polybar/default/launch.sh
	chmod +x ~/.config/polybar/beach/launch.sh	
else
	echo "Vicyos modified Polybar is already installed"
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

###### Trizen #######

# Hplib Gui: 
trizen -S python-pyqt5 --needed --noconfirm

trizen -S wget --needed --noconfirm
trizen -S redshiftgui-bin --needed --noconfirm
trizen -S python --needed --noconfirm
trizen -S google-chrome --needed --noconfirm
trizen -S visual-studio-code-bin --needed --noconfirm
trizen -S android-studio --needed --noconfirm
}

polybar_monitors(){
###############################################################
# ONLY FOR TESTING PURPOSE. IT'S STILL IN DEVELOPMENET !!!!!!!
# It will be soon moved to: "~/.config/openbox/autostart"
###############################################################

# If HDMI1 is connected, it will print (echo) only "HDMI1 connected"
conected_monitor=$(xrandr | grep -E "(HDMI1)" | sed -E 's/(.{15}).+/\1/') 

# Check if HDMI1 is connected, if so...
# Set the proper resolution for each monitor and start one polybar for each monitor. 
# But if HDMI1 isn't connected, boot only one polybar for the the primary monitor.
if [ "$conected_monitor" == "HDMI1 connected" ]; then
	# clear
	echo "Second monitor is connected"
else
	# clear
	echo "There is no second monitor connected"
fi
}

loading_banner
# reset_color
# add_vicyos_repo 
# trizen
# vicyos_polybar
# vicyos_zsh
# personal_pkgs
update 
# polybar_monitors