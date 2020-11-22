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
        ${DARK_GRAY}│ ${BLUE}Desktop Environment   :   $v_desktop                            ${DARK_GRAY}│
        ${DARK_GRAY}│ ${BLUE}Author                :   $v_author                 ${DARK_GRAY}│
        ${DARK_GRAY}│ ${BLUE}My Github             :   $v_github               ${DARK_GRAY}│
        ${DARK_GRAY}│ ${BLUE}Important Note        :   $v_note         ${DARK_GRAY}│
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
counter=10
v_desktop="${GRAY}Openbox"
v_author="${GRAY}Vicyos (felipendc)"
v_github="${GRAY}github.com/felipendc"
v_note="${GRAY}I use Arch! btw... Hahaha!"

until [ "$counter" == 1 ];
do
    if [ ! "$counter" == 1 ]; then
        counter=$((counter-1))
        printf "\033c"
        vicyos_banner
        sleep 1
    fi

    if [ "$counter" == 9 ]; then
        v_desktop="${BLUE}Openbox"
        v_author="${GRAY}Vicyos (felipendc)"
        v_github="${GRAY}github.com/felipendc"
        v_note="${GRAY}I use Arch! btw... Hahaha!"
    fi

    if [ "$counter" == 8 ]; then
        v_desktop="${RED}Openbox"
        v_author="${BLUE}Vicyos (felipendc)"
        v_github="${GRAY}github.com/felipendc"
        v_note="${GRAY}I use Arch! btw... Hahaha!"
    fi

    if [ "$counter" == 7 ]; then
        v_desktop="${GREEN}Openbox"
        v_author="${RED}Vicyos (felipendc)"
        v_github="${BLUE}github.com/felipendc"
        v_note="${GRAY}I use Arch! btw... Hahaha!"
    fi


    if [ "$counter" == 6 ]; then
        v_desktop="${ORANGE}Openbox"
        v_author="${GREEN}Vicyos (felipendc)"
        v_github="${RED}github.com/felipendc"
        v_note="${BLUE}I use Arch! btw... Hahaha!"
    fi

    if [ "$counter" == 5 ]; then
        v_desktop="${GRAY}Openbox"
        v_author="${ORANGE}Vicyos (felipendc)"
        v_github="${GREEN}github.com/felipendc"
        v_note="${RED}I use Arch! btw... Hahaha!"
    fi

    if [ "$counter" == 4 ]; then
        v_desktop="${GRAY}Openbox"
        v_author="${GRAY}Vicyos (felipendc)"
        v_github="${ORANGE}github.com/felipendc"
        v_note="${GREEN}I use Arch! btw... Hahaha!"
    fi

    if [ "$counter" == 3 ]; then
        v_desktop="${GRAY}Openbox"
        v_author="${GRAY}Vicyos (felipendc)"
        v_github="${GRAY}github.com/felipendc"
        v_note="${ORANGE}I use Arch! btw... Hahaha!"
    fi

    if [ "$counter" == 2 ]; then
        v_desktop="${GRAY}Openbox"
        v_author="${GRAY}Vicyos (felipendc)"
        v_github="${GRAY}github.com/felipendc"
        v_note="${GRAY}I use Arch! btw... Hahaha!"
    fi

    if [ "$counter" == 1 ]; then
        printf "\033c"
        counter=" "
        here_we_go
        sleep 2
        break
    fi
done

# Reset the command lines color
tput sgr0
tput op
}