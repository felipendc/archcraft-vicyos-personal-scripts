#!/bin/bash
# github.com/felipendc

#-------------Variables--------------#

#------------------------------------#
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
	if [ -f "$trizen_file" ];then
		sudo rm -Rv trizen_for_vicyos.tar.gz
	fi
until [ -f "$trizen_file" ] 

do 

	wget -c https://aur.archlinux.org/cgit/aur.git/snapshot/trizen.tar.gz -O trizen_for_vicyos.tar.gz
	sleep 3
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

# fix timezone:
trizen -S chrony --needed --noconfirm

#redshiftgui-bin
trizen -S gnome-system-monitor --needed --noconfirm

# Davinci Resolve fix:
trizen -S ocl-icd --needed --noconfirm

trizen -S playerctl --needed --noconfirm
trizen -S gimp --needed --noconfirm
trizen -S inkscape --needed --noconfirm
trizen -S qbittorrent --needed --noconfirm
trizen -S vlc --needed --noconfirm
trizen -S youtube-dl --needed --noconfirm
trizen -S clementine --needed --noconfirm
trizen -S krita --needed --noconfirm
trizen -S gnome-calculator --needed --noconfirm
trizen -S clipgrab --needed --noconfirm
trizen -S pinta --needed --noconfirm
trizen -S filezilla --needed --noconfirm

#wget 
trizen -S python  --needed --noconfirm
trizen -S python-pip --needed --noconfirm
trizen -S curl --needed --noconfirm
trizen -S simple-scan --needed --noconfirm
trizen -S arandr --needed --noconfirm
trizen -S hwinfo --needed --noconfirm

# Hplib Gui:
trizen -S python-pyqt4 --needed --noconfirm
trizen -S python-pyqt5 --needed --noconfirm

}

#update ok
#vicyos_repo ok
#add_vicyos_repo ok
download_trizen 
personal_pkgs

