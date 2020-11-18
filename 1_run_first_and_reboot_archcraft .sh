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

reboot_os(){
sudo reboot
}


loading_banner
update
personal_pkgs
reboot_os