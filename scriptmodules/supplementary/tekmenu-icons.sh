#!/usr/bin/env bash

# This file is part of the microplay-hub
# Designs by Liontek1985
# for RetroPie and offshoot
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#
# tekmenu-iconscript v1.51 - 2023-11-19

rp_module_id="tekmenu-icons"
rp_module_desc="Retropiemenu Icon-Settings for ES"
rp_module_repo="git https://github.com/Liontek1985/tekmenu-icons.git master"
rp_module_section="main"
rp_module_flags="noinstclean"

function depends_tekmenu-icons() {
    local depends=(cmake)
     getDepends "${depends[@]}"
}

function _update_hook_retropiemenu-nxt() {
    renameModule "rpmenu-icons" "tekmenu-icons"
}

function sources_tekmenu-icons() {
    if [[ -d "$md_inst" ]]; then
        git -C "$md_inst" reset --hard  # ensure that no local changes exist
    fi
    gitPullOrClone "$md_inst"
}

function install_tekmenu-icons() {

    if [[ ! -f "$configdir/all/$md_id.cfg" ]]; then
        iniConfig "=" '"' "$configdir/all/$md_id.cfg"
        iniSet "RPMCHANGE" "default"
        iniSet "RPMPATH" "retropiemenu"
    fi

    if isPlatform "sun50i-h616"; then
        iniSet "RPMPATH" "retropiemenu-nxt"
    elif isPlatform "sun50i-h6"; then
        iniSet "RPMPATH" "retropiemenu-nxt"
    elif isPlatform "sun8i-h3"; then
        iniSet "RPMPATH" "retropiemenu-nxt"
    elif isPlatform "armv7-mali"; then
        iniSet "RPMPATH" "retropiemenu-nxt"
    elif isPlatform "rpi"; then
        iniSet "RPMPATH" "retropiemenu"
    fi	
	
	
	configrpm_tekmenu-icons
	
        iniConfig "=" '"' "$configdir/all/$md_id.cfg"
		
        iniGet "RPMCHANGE"
        local rpmchange=${ini_value}
        iniGet "RPMPATH"
        local rpmpath=${ini_value}
	
		local space="/"
		local rpdir="$datadir$space$rpmpath"
	
    local rpiconsetup="$scriptdir/scriptmodules/supplementary"
	
    cd "$md_inst"
	
    cp -r "$rpdir/icons" "$md_inst/icons"
    cp -r "$rpdir/icons" "$md_inst/icons_bkup"
#	cp -r "tekmenu-icons.sh" "$rpiconsetup/tekmenu-icons.sh"
    chown -R $user:$user "$rpdir/icons"	
    chown -R $user:$user "$rpiconsetup/tekmenu-icons.sh"
	chmod 755 "$rpiconsetup/tekmenu-icons.sh"
	chmod 755 "$rpdir/icons"
	rm -r "tekmenu-icons.sh"

	

	
    chown $user:$user "$configdir/all/$md_id.cfg"
	chmod 755 "$configdir/all/$md_id.cfg"
	
}


function remove_tekmenu-icons() {

	configrpm_tekmenu-icons
	
        iniConfig "=" '"' "$configdir/all/$md_id.cfg"
		
        iniGet "RPMCHANGE"
        local rpmchange=${ini_value}
        iniGet "RPMPATH"
        local rpmpath=${ini_value}
	
		local space="/"
		local rpdir="$datadir$space$rpmpath"
	
    rm -rf "$rpdir/icons"	
    cp -r "$md_inst/icons_bkup" "$rpdir/icons"
    chown -R $user:$user "$rpdir/icons"
	chmod 755 "$rpdir/icons"
	rm -rf "$md_inst"

    rm -r "$configdir/all/$md_id.cfg"	
}

function configrpm_tekmenu-icons() {
	chown $user:$user "$configdir/all/$md_id.cfg"	
    iniConfig "=" '"' "$configdir/all/$md_id.cfg"	
}

function changestatus_tekmenu-icons() {

		local space="/"
		local rpdir="$datadir$space$rpmpath"


    options=(
		C1 "Default Icon-Set [choose]"
		C2 "NES Style Icon-Set [choose]"
		C3 "SNES Style Icon-Set [choose]"
		C4 "SMD-Genesis Style Icon-Set [choose]"
		C5 "PCE-TG16 Style Icon-Set [choose]"
		C6 "Gameboy Style Icon-Set [choose]"
		C7 "Famicom Style Icon-Set [choose]"
		C8 "Modern icon-set [choose]"
		XX "[current setting: $rpmchange]"
    )
    local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option." 22 86 16)
    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

    case "$choice" in
        C1)
			rm -rf "$rpdir/icons"
			cd "$md_inst"
 			cp -r "icons" "$rpdir/icons"
			chown -R $user:$user "$rpdir/icons"
			chmod 755 "$rpdir/icons"
			iniSet "RPMCHANGE" "MODERN"
			printMsgs "dialog" "Settings menu default icons installed."
                ;;
        C2)
			rm -rf "$rpdir/icons"
			cd "$md_inst"
 			cp -r "icons_nes" "$rpdir/icons"
			chown -R $user:$user "$rpdir/icons"
			chmod 755 "$rpdir/icons"
			iniSet "RPMCHANGE" "NES"
 			printMsgs "dialog" "Settings menu nes icons installed."
                ;;
        C3)
			rm -rf "$rpdir/icons"
			cd "$md_inst"
			cp -r "icons_snes" "$rpdir/icons"
			chown -R $user:$user "$rpdir/icons"
			chmod 755 "$rpdir/icons"
			iniSet "RPMCHANGE" "SNES"
			printMsgs "dialog" "Settings menu snes icons installed."
                ;;
        C4)
			rm -rf "$rpdir/icons"
			cd "$md_inst"
			cp -r "icons_smd" "$rpdir/icons"
			chown -R $user:$user "$rpdir/icons"
			chmod 755 "$rpdir/icons"
			iniSet "RPMCHANGE" "SMD-GENESIS"
			printMsgs "dialog" "Settings menu smd-genesis icons installed."
                ;;
        C5)
			rm -rf "$rpdir/icons"
			cd "$md_inst"
			cp -r "icons_pce" "$rpdir/icons"
			chown -R $user:$user "$rpdir/icons"
			chmod 755 "$rpdir/icons"
			iniSet "RPMCHANGE" "PCE-TG16"
			printMsgs "dialog" "Settings menu pce-tg16 icons installed."
                ;;
        C6)
			rm -rf "$rpdir/icons"
			cd "$md_inst"
			cp -r "icons_gb" "$rpdir/icons"
			chown -R $user:$user "$rpdir/icons"
			chmod 755 "$rpdir/icons"
			iniSet "RPMCHANGE" "GAMEBOY"
			printMsgs "dialog" "Settings menu gameboy icons installed."
                ;;
        C7)
			rm -rf "$rpdir/icons"
			cd "$md_inst"
			cp -r "icons_fds" "$rpdir/icons"
			chown -R $user:$user "$rpdir/icons"
			chmod 755 "$rpdir/icons"
			iniSet "RPMCHANGE" "FAMICOM"
			printMsgs "dialog" "Settings menu famicom icons installed."
                ;;
        C8)
            rm -rf "$rpdir/icons"
			cd "$md_inst"
            cp -r "icons_modern" "$rpdir/icons"
            chown -R $user:$user "$rpdir/icons"
			chmod 755 "$rpdir/icons"
			iniSet "RPMCHANGE" "MODERN"
			printMsgs "dialog" "Settings menu modern icons installed."
                ;;
    esac
}

function changepath_tekmenu-icons() {

    options=(
		P1 "Menu Path [retropiemenu]"
		P2 "Menu Path [retropiemenu-nxt]"
		P3 "Menu Path [custom folder]"
		XX "[current path: $rpmpath]"
    )
    local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option." 22 86 16)
    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

    case "$choice" in
        P1)
			iniSet "RPMPATH" "retropiemenu"
			printMsgs "dialog" "RPM-Path changed to retropiemenu"
                ;;
        P2)
			iniSet "RPMPATH" "retropiemenu-nxt"
 			printMsgs "dialog" "RPM-Path changed to retropiemenu-nxt"
                ;;
        P3)
			editFile "/opt/retropie/configs/all/tekmenu-icons.cfg"
                ;;
    esac
}

function gui_tekmenu-icons() {

    local cmd=(dialog --default-item "$default" --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
	
        iniConfig "=" '"' "$configdir/all/$md_id.cfg"
		
        iniGet "RPMCHANGE"
        local rpmchange=${ini_value}
        iniGet "RPMPATH"
        local rpmpath=${ini_value}
	
    local options=(
    )
        options+=(	
            I "RetroPie Menu Icon-Set [$rpmchange]"
            P "Retromenu Path [$rpmpath]"
            TEK "### Script by Liontek1985 ###"
        )
		
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
		
        iniConfig "=" '"' "$configdir/all/$md_id.cfg"
		
        iniGet "RPMCHANGE"
        local rpmchange=${ini_value}
        iniGet "RPMPATH"
        local rpmpath=${ini_value}
		
    if [[ -n "$choice" ]]; then
        case "$choice" in
            I)
				configrpm_tekmenu-icons
				changestatus_tekmenu-icons
                ;;	
            P)
				configrpm_tekmenu-icons
				changepath_tekmenu-icons
                ;;			
        esac
    fi
}
