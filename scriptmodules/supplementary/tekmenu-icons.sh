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
# tekmenu-iconscript v1.41 - 2023-11-17

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

    if isPlatform "sun50i-h616"; then
		local rpdir="$datadir/retropiemenu-nxt"
    elif isPlatform "sun50i-h6"; then
		local rpdir="$datadir/retropiemenu-nxt"
    elif isPlatform "sun8i-h3"; then
		local rpdir="$datadir/retropiemenu-nxt"
    elif isPlatform "armv7-mali"; then
		local rpdir="$datadir/retropiemenu-nxt"
    elif isPlatform "rpi"; then
		local rpdir="$datadir/retropiemenu-nxt"
		local rpdir2="$datadir/retropiemenu"
    fi
	
    local rpiconsetup="$scriptdir/scriptmodules/supplementary"
	
    cd "$md_inst"
	
    cp -r "$rpdir/icons" "$md_inst/icons"
    cp -r "$rpdir/icons" "$md_inst/icons_bkup"
#	cp -r "rpmenuicons.sh" "$rpiconsetup/rpmenuicons.sh"
    chown -R $user:$user "$rpdir/icons"	
    chown -R $user:$user "$rpiconsetup/rpmenuicons.sh"
	chmod 755 "$rpiconsetup/rpmenuicons.sh"
	chmod 755 "$rpdir/icons"
	rm -r "rpmenuicons.sh"

    if isPlatform "rpi"; then
    	cd "$md_inst"
	
    	cp -r "$rpdir2/icons" "$md_inst2/icons_rpi"
    	cp -r "$rpdir2/icons" "$md_inst/icons_bkup_rpi"
    	chown -R $user:$user "$rpdir2/icons"	
    fi
	
    if [[ ! -f "$configdir/all/$md_id.cfg" ]]; then
        iniConfig "=" '"' "$configdir/all/$md_id.cfg"
        iniSet "RPMCHANGE" "default"		
    fi
    chown $user:$user "$configdir/all/$md_id.cfg"
	chmod 755 "$configdir/all/$md_id.cfg"
	
}


function remove_tekmenu-icons() {
    if isPlatform "sun50i-h616"; then
		local rpdir="$datadir/retropiemenu-nxt"
    elif isPlatform "sun50i-h6"; then
		local rpdir="$datadir/retropiemenu-nxt"
    elif isPlatform "sun8i-h3"; then
		local rpdir="$datadir/retropiemenu-nxt"
    elif isPlatform "armv7-mali"; then
		local rpdir="$datadir/retropiemenu-nxt"
    elif isPlatform "rpi"; then
		local rpdir="$datadir/retropiemenu-nxt"
		local rpdir2="$datadir/retropiemenu"
    fi
	
    rm -rf "$rpdir/icons"
    cp -r "$md_inst/icons_bkup" "$rpdir/icons"
    chown -R $user:$user "$rpdir/icons"
	chmod 755 "$rpdir/icons"
	rm -rf "$md_inst"

    if isPlatform "rpi"; then
    	rm -rf "$rpdir2/icons_rpi"
    	cp -r "$md_inst/icons_bkup_rpi" "$rpdir2/icons"
    	chown -R $user:$user "$rpdir2/icons"
	chmod 755 "$rpdir2/icons"
	rm -rf "$md_inst"
    fi

    rm -r "$configdir/all/$md_id.cfg"	
}

function configrpm_tekmenu-icons() {
	chown $user:$user "$configdir/all/$md_id.cfg"	
    iniConfig "=" '"' "$configdir/all/$md_id.cfg"	
}

function changestatus_tekmenu-icons() {

    if isPlatform "sun50i-h616"; then
		local rpdir="$datadir/retropiemenu-nxt"
    elif isPlatform "sun50i-h6"; then
		local rpdir="$datadir/retropiemenu-nxt"
    elif isPlatform "sun8i-h3"; then
		local rpdir="$datadir/retropiemenu-nxt"
    elif isPlatform "armv7-mali"; then
		local rpdir="$datadir/retropiemenu-nxt"
    elif isPlatform "rpi"; then
		local rpdir="$datadir/retropiemenu-nxt"
		local rpdir2="$datadir/retropiemenu"
    fi

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
			    if isPlatform "rpi"; then
				rm -rf "$rpdir2/icons"
				cd "$md_inst"
 				cp -r "icons_rpi" "$rpdir2/icons"
				chown -R $user:$user "$rpdir2/icons"
				chmod 755 "$rpdir2/icons"
    			    fi
			iniSet "RPMCHANGE" "MODERN"
			printMsgs "dialog" "Settings menu default icons installed."
                ;;
        C2)
			rm -rf "$rpdir/icons"
			cd "$md_inst"
 			cp -r "icons_nes" "$rpdir/icons"
			chown -R $user:$user "$rpdir/icons"
			chmod 755 "$rpdir/icons"
   			    if isPlatform "rpi"; then
				rm -rf "$rpdir2/icons"
				cd "$md_inst"
 				cp -r "icons_nes" "$rpdir2/icons"
				chown -R $user:$user "$rpdir2/icons"
				chmod 755 "$rpdir2/icons"
    			    fi
			iniSet "RPMCHANGE" "NES"
 			printMsgs "dialog" "Settings menu nes icons installed."
                ;;
        C3)
			rm -rf "$rpdir/icons"
			cd "$md_inst"
			cp -r "icons_snes" "$rpdir/icons"
			chown -R $user:$user "$rpdir/icons"
			chmod 755 "$rpdir/icons"
   			    if isPlatform "rpi"; then
				rm -rf "$rpdir2/icons"
				cd "$md_inst"
 				cp -r "icons_snes" "$rpdir2/icons"
				chown -R $user:$user "$rpdir2/icons"
				chmod 755 "$rpdir2/icons"
    			    fi
			iniSet "RPMCHANGE" "SNES"
			printMsgs "dialog" "Settings menu snes icons installed."
                ;;
        C4)
			rm -rf "$rpdir/icons"
			cd "$md_inst"
			cp -r "icons_smd" "$rpdir/icons"
			chown -R $user:$user "$rpdir/icons"
			chmod 755 "$rpdir/icons"
   			    if isPlatform "rpi"; then
				rm -rf "$rpdir2/icons"
				cd "$md_inst"
 				cp -r "icons_smd" "$rpdir2/icons"
				chown -R $user:$user "$rpdir2/icons"
				chmod 755 "$rpdir2/icons"
    			    fi
			iniSet "RPMCHANGE" "SMD-GENESIS"
			printMsgs "dialog" "Settings menu smd-genesis icons installed."
                ;;
        C5)
			rm -rf "$rpdir/icons"
			cd "$md_inst"
			cp -r "icons_pce" "$rpdir/icons"
			chown -R $user:$user "$rpdir/icons"
			chmod 755 "$rpdir/icons"
   			    if isPlatform "rpi"; then
				rm -rf "$rpdir2/icons"
				cd "$md_inst"
 				cp -r "icons_pce" "$rpdir2/icons"
				chown -R $user:$user "$rpdir2/icons"
				chmod 755 "$rpdir2/icons"
    			    fi
			iniSet "RPMCHANGE" "PCE-TG16"
			printMsgs "dialog" "Settings menu pce-tg16 icons installed."
                ;;
        C6)
			rm -rf "$rpdir/icons"
			cd "$md_inst"
			cp -r "icons_gb" "$rpdir/icons"
			chown -R $user:$user "$rpdir/icons"
			chmod 755 "$rpdir/icons"
   			    if isPlatform "rpi"; then
				rm -rf "$rpdir2/icons"
				cd "$md_inst"
 				cp -r "icons_gb" "$rpdir2/icons"
				chown -R $user:$user "$rpdir2/icons"
				chmod 755 "$rpdir2/icons"
    			    fi
			iniSet "RPMCHANGE" "GAMEBOY"
			printMsgs "dialog" "Settings menu gameboy icons installed."
                ;;
        C7)
			rm -rf "$rpdir/icons"
			cd "$md_inst"
			cp -r "icons_fds" "$rpdir/icons"
			chown -R $user:$user "$rpdir/icons"
			chmod 755 "$rpdir/icons"
   			    if isPlatform "rpi"; then
				rm -rf "$rpdir2/icons"
				cd "$md_inst"
 				cp -r "icons_fds" "$rpdir2/icons"
				chown -R $user:$user "$rpdir2/icons"
				chmod 755 "$rpdir2/icons"
    			    fi
			iniSet "RPMCHANGE" "FAMICOM"
			printMsgs "dialog" "Settings menu famicom icons installed."
                ;;
        C8)
            rm -rf "$rpdir/icons"
			cd "$md_inst"
            		cp -r "icons_modern" "$rpdir/icons"
            		chown -R $user:$user "$rpdir/icons"
			chmod 755 "$rpdir/icons"
   			    if isPlatform "rpi"; then
				rm -rf "$rpdir2/icons"
				cd "$md_inst"
 				cp -r "icons_modern" "$rpdir2/icons"
				chown -R $user:$user "$rpdir2/icons"
				chmod 755 "$rpdir2/icons"
    			    fi
			iniSet "RPMCHANGE" "MODERN"
			printMsgs "dialog" "Settings menu modern icons installed."
                ;;
    esac
}

function gui_tekmenu-icons() {

    local cmd=(dialog --default-item "$default" --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
	
        iniConfig "=" '"' "$configdir/all/$md_id.cfg"
		
        iniGet "RPMCHANGE"
        local rpmchange=${ini_value}
	
    local options=(
    )
        options+=(	
            I "RetroPie Menu Icon-Set (change me)"
            X "[current setting: $rpmchange]"
            TEK "### Script by Liontek1985 ###"
        )
		
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
		
        iniConfig "=" '"' "$configdir/all/$md_id.cfg"
		
        iniGet "RPMCHANGE"
        local rpmchange=${ini_value}
		
    if [[ -n "$choice" ]]; then
        case "$choice" in
            I)
				configrpm_tekmenu-icons
				changestatus_tekmenu-icons
                ;;
            X)
				configrpm_tekmenu-icons
				changestatus_tekmenu-icons
                ;;				
        esac
    fi
}
