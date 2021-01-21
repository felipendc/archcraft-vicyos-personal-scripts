d#!/bin/bash

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
sudo pacman -Syyu --noconfirm
yay -Syu --noconfirm
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

flatpak_apps(){
sudo flatpak install -y needed_files/flatpak/org.onlyoffice.desktopeditors.flatpakref
sudo flatpak install -y needed_files/flatpak/net.codeindustry.MasterPDFEditor.flatpakref
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
sudo pacman -S whatsapp-nativefier --noconfirm

# Once installed open it on the terminal:
# sudo balena-etcher-electron
sudo pacman -S balena-etcher --noconfirm

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
sudo pacman -S xsensors --noconfirm
sudo pacman -S flatpak --noconfirm
sudo pacman -S handbrake --noconfirm

###audio
# sudo pacman -S alsa-firmware --noconfirm
# sudo pacman -S alsa-plugins --noconfirm
# sudo pacman -S alsa-lib --noconfirm
# sudo pacman -S alsa-utils --noconfirm
# sudo pacman -S gst-libav --noconfirm
# sudo pacman -S gst-plugins-bad --noconfirm
# sudo pacman -S gst-plugins-base --noconfirm
# sudo pacman -S gst-plugins-good --noconfirm
# sudo pacman -S gst-plugins-ugly --noconfirm
# sudo pacman -S gstreamer --noconfirm
# sudo pacman -S libdvdcss --noconfirm
# sudo pacman -S pulseaudio --noconfirm
# sudo pacman -S pulseaudio-alsa --noconfirm
# sudo pacman -S pavucontrol --noconfirm
}

trizen_personal_pkgs() {
###### Trizen #######

# Hplib Gui: 
trizen -S python-pyqt5 --needed --noconfirm

# github-desktop
trizen -S gconf --needed --noconfirm
trizen -S github-desktop --needed --noconfirm

trizen -S google-chrome --needed --noconfirm
trizen -S telegram-desktop-bin --needed --noconfirm
trizen -S wget --needed --noconfirm
trizen -S redshiftgui-bin --needed --noconfirm
trizen -S python --needed --noconfirm
trizen -S visual-studio-code-bin --needed --noconfirm
trizen -S android-studio --needed --noconfirm
#trizen -S onlyoffice-bin --needed --noconfirm
trizen -S kdenlive --needed --noconfirm

# Zsh stuff
trizen -S oh-my-zsh-git --needed --noconfirm
trizen -S zsh-completions --needed --noconfirm
trizen -S zsh-syntax-highlighting --needed --noconfirm
}

nvidia_install(){
sudo pacman -Rsd nvidia --noconfirm
sudo pacman -Rsd nvidia-settings --noconfirm
sudo pacman -Rsd nvidia-utils --noconfirm

sudo pacman -S libgl

trizen -S nvidia-390xx
sudo pacman -S nvidia-settings
sudo nvidia-settings
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
		fix_bluetooth
		printers
		vicyos_polybar_desktop 
		vicyos_zsh
		snap_apps
		flatpak_apps
		trizen_personal_pkgs
		personal_pkgs
		nvidia_install
		update 
	;;
	l )
		# Setting up files for Laptop
		printf "\033c"
		loading_banner
		fix_bluetooth
		printers
		vicyos_polybar_laptop
		vicyos_zsh
		snap_apps
		flatpak_apps
		trizen_personal_pkgs
		personal_pkgs
		update 
	;;
esac
}
choose_installation
