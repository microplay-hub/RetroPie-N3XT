#!/usr/bin/env bash

# This file is part of the microplay-hub Project
# Own Scripts useable for RetroPie and offshoot
#
# The microplay-hub Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the main directory of this distribution and
#
# The Core script is based on The RetroPie Project https://retropie.org.uk Modules
##

rp_module_id="bioz"
rp_module_desc="BIOZ-Pack for RetroPie"
rp_module_section="driver"
rp_module_flags="noinstclean"

function depends_bioz() {
    local depends=(cmake)
     getDepends "${depends[@]}"
}

function install_bin_bioz() {
    if [[ -d "$md_inst" ]]; then
        git -C "$md_inst" reset --hard  # ensure that no local changes exist
    fi
    local BIOZ="BIOS"
    downloadAndExtract "https://github.com/microplay-hub/mpcore-library/raw/main/package/BIOZ.tar.gz" "$md_inst/$BIOZ" --strip-components 1
    downloadAndExtract "https://github.com/microplay-hub/mpcore-library/raw/main/package/BIOZfly.tar.gz" "$md_inst/$BIOZ" --strip-components 1
    cd "$md_inst"

	cp -rvf "$BIOZ" "$datadir"	
    chown -R $user:$user "$datadir/$BIOZ"	
	chmod -R 755 "$datadir/$BIOZ"
}

function remove_bioz() {
	rm -rf "$md_inst"
}

function gui_bioz() {

    while true; do
		local BIOZ="BIOS"
        local options=(	
            1 "Recopy BIOZ"
        )
        local cmd=(dialog --default-item "$default" --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            1)
				cd "$md_inst"
				cp -rvf "$BIOZ" "$datadir"	
				chown -R $user:$user "$datadir/$BIOZ"
				chmod -R 755 "$datadir/$BIOZ"				
                printMsgs "dialog" "BIOZ successfully copied"
                ;;
        esac
    done
}
