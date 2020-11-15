#!/bin/bash
# github.com/felipendc

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

download_trizen(){

# Download trizen snapshot (PKGBUILD file) 
# Wait until trizen snapshot is downloaded and trigger the trizen installation function (install_trizen)
if pacman -Qi trizen &> /dev/null; then
	echo "Trizen is already installed." 
else
	trizen_file="trizen_for_vicyos.tar.gz" 
	if [ -f "$trizen_file" ]; then
		sudo rm -Rv trizen_for_vicyos.tar.gz
	fi
	
until [ -f "$trizen_file" ] 
do 
	wget -c https://aur.archlinux.org/cgit/aur.git/snapshot/trizen.tar.gz -O trizen_for_vicyos.tar.gz
	sleep 10
	if [ -f "$trizen_file" ]; then
		break
	else
		echo "trizen_for_vicyos.tar.gz doesn't exist" 
	fi
done
install_trizen
fi
}

install_trizen(){

# Compile trizen, install it, and clean up the temp files
cd trizen
makepkg -s
sudo pacman -U trizen*.zst --noconfirm
cd ../
rm -Rvf trizen
rm -Rvf trizen_for_vicyos.tar.gz
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

# Remove old .zshrc to avoid any conflicts
# Move vicyos_modified_zshrc to Home folder renamed to .zshrc
rm -R $HOME/.zshrc
cp -r needed_files/vicyos_modified_zshrc/vicyos_modified_zshrc $HOME/.zshrc
source $HOME/.zshrc
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


###### Trizen #######

# Hplib Gui:
#trizen -S python-pyqt4 --needed --noconfirm 
trizen -S python-pyqt5 --needed --noconfirm

trizen -S wget --needed --noconfirm
trizen -S redshiftgui-bin --needed --noconfirm
trizen -S python --needed --noconfirm
trizen -S google-chrome --needed --noconfirm
trizen -S visual-studio-code-bin --needed --noconfirm
trizen -S android-studio --needed --noconfirm
trizen -S flutter --needed --noconfirm
sudo flutter
sudo flutter doctor
}

add_vicyos_repo 
download_trizen 
vicyos_polybar
vicyos_zsh
personal_pkgs
update 
