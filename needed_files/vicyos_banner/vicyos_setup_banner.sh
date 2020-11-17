#!/bin/bash

################################################################
# Written to be used on my Thinkpad T430 with Archcraft Linux. #
# Desktop Environment   :   Openbox                            #
# Author                :   Vicyos (felipendc)                 #
# My Github             :   github.com/felipendc               #
# Important Note        :   I use Arch! btw... Hahaha!         #
################################################################

## ANSI Colors (FG & BG)
RED="$(printf '\033[31m')"  GREEN="$(printf '\033[32m')"  ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  CYAN="$(printf '\033[36m')"  WHITE="$(printf '\033[37m')" BLACK="$(printf '\033[30m')"
REDBG="$(printf '\033[41m')"  GREENBG="$(printf '\033[42m')"  ORANGEBG="$(printf '\033[43m')"  BLUEBG="$(printf '\033[44m')"
MAGENTABG="$(printf '\033[45m')"  CYANBG="$(printf '\033[46m')"  WHITEBG="$(printf '\033[47m')" BLACKBG="$(printf '\033[40m')"

GRAY="$(printf '\e[0;39m')" DARK_GRAY="$(printf '\e[1;30m')" LIGHT_CYAN="$(printf '\e[1;36m')"
RESET="$(printf '\u001b[0m')"


## Banner
vicyos_banner() {
    clear
    cat <<- _EOF_
        ${DARK_GRAY}┌──────────────────────────────────────────────────────────────┐
        ${DARK_GRAY}│ ${WHITE}Written to be used on my Thinkpad T430 with Archcraft Linux. ${DARK_GRAY}│
        ${DARK_GRAY}│                                                              ${DARK_GRAY}│
        ${DARK_GRAY}│ ${BLUE}Desktop Environment   :   ${GRAY}Openbox                            ${DARK_GRAY}│
        ${DARK_GRAY}│ ${BLUE}Author                :   ${GRAY}Vicyos (felipendc)                 ${DARK_GRAY}│
        ${DARK_GRAY}│ ${BLUE}My Github             :   ${GRAY}github.com/felipendc               ${DARK_GRAY}│
        ${DARK_GRAY}│ ${BLUE}Important Note        :   ${GRAY}I use Arch! btw... Hahaha!         ${DARK_GRAY}│
        ${DARK_GRAY}│                                                              ${DARK_GRAY}│
        ${DARK_GRAY}│ ${GREEN}Vicyos personal script will start in: $counter                      ${DARK_GRAY}│
        ${DARK_GRAY}└──────────────────────────────────────────────────────────────┘
	_EOF_
}

here_we_go() {
    clear
    cat <<- _EOF_
        ${DARK_GRAY}┌──────────────────────────────────────────────────────────────┐
        ${DARK_GRAY}│ ${WHITE}Written to be used on my Thinkpad T430 with Archcraft Linux. ${DARK_GRAY}│
        ${DARK_GRAY}│                                                              ${DARK_GRAY}│
        ${DARK_GRAY}│ ${BLUE}Desktop Environment   :   ${GRAY}Openbox                            ${DARK_GRAY}│
        ${DARK_GRAY}│ ${BLUE}Author                :   ${GRAY}Vicyos (felipendc)                 ${DARK_GRAY}│
        ${DARK_GRAY}│ ${BLUE}My Github             :   ${GRAY}github.com/felipendc               ${DARK_GRAY}│
        ${DARK_GRAY}│ ${BLUE}Important Note        :   ${GRAY}I use Arch! btw... Hahaha!         ${DARK_GRAY}│
        ${DARK_GRAY}│                                                              ${DARK_GRAY}│
        ${DARK_GRAY}│ ${GREEN}Vicyos personal script will start in: ${RED}Here we go!            ${DARK_GRAY}│
        ${DARK_GRAY}└──────────────────────────────────────────────────────────────┘
	_EOF_
}

loading_banner(){

counter=6

until [ "$counter" == 1 ];
do
    if [ ! "$counter" == 1 ]; then
        counter=$((counter-1))
        clear
        vicyos_banner
        sleep 1
    fi

    if [ "$counter" == 1 ]; then
        clear
        counter=" "
        here_we_go
        sleep 2
        break
    fi
done
}
# here_we_go
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
loading_banner
