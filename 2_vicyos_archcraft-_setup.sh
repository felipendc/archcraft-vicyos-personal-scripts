#!/bin/bash
# github.com/felipendc

update () {
# Update the packages
sudo pacman -Syyu
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

echo "Unpacking file" 
rm -Rvf trizen
tar -zxvf trizen_for_vicyos.tar.gz

cd trizen
makepkg -s
sudo pacman -U trizen*.zst --noconfirm
cd ../
echo"Cleaning up temp files"
rm -Rvf trizen
rm -Rvf trizen_for_vicyos.tar.gz
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

###### Trizen #######

# Hplib Gui:
trizen -S python-pyqt4 --needed --noconfirm
trizen -S python-pyqt5 --needed --noconfirm

trizen -S wget --needed --noconfirm
trizen -S redshiftgui-bin --needed --noconfirm
trizen -S python --needed --noconfirm
trizen -S google-chrome --needed --noconfirm
trizen -S visual-studio-code-bin --needed --noconfirm
trizen -S android-studio --needed --noconfirm
trizen -S flutter --needed --noconfirm
}

add_vicyos_repo 
download_trizen 
personal_pkgs
update 
