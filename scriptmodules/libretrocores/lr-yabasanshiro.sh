#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-yabasanshiro"
rp_module_desc="Sega Saturn emu - Yabasanshiro for libretro"
rp_module_help="ROM Extensions: .iso .bin .zip\n\nCopy your Sega Saturn roms to $romdir/saturn\n\nCopy the required BIOS file saturn_bios_us.bin and saturn_bios_jp.bin to $biosdir"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/yabause/master/yabause/COPYING"
rp_module_repo="git https://github.com/microplay-hub/yabause.git yabasanshiro"
rp_module_section="exp"
rp_module_flags="!armv6"

function sources_lr-yabasanshiro() {
    gitPullOrClone
}

function build_lr-yabasanshiro() {
    if isPlatform "rpi4"; then       
        make -j2 -C yabause/src/libretro/ platform=rpi4_32
    else
        exit
    fi
    md_ret_require="$md_build/yabause/src/libretro/yabasanshiro_libretro.so"
}

function install_lr-yabasanshiro() {
    md_ret_files=(
        'yabause/src/libretro/yabasanshiro_libretro.so'
    )
}

function configure_lr-yabasanshiro() {
    mkRomDir "saturn"
    ensureSystemretroconfig "saturn"
    addEmulator 0 "$md_id" "saturn" "$md_inst/yabasanshiro_libretro.so"
    addSystem "saturn"
	
    
    # set core options
    #setRetroArchCoreOption "${dir_name}yabasanshiro_addon_cart" "4M_extended_ram"
    #setRetroArchCoreOption "${dir_name}yabasanshiro_force_hle_bios" "disabled"
    #setRetroArchCoreOption "${dir_name}yabasanshiro_frameskip" "disabled"
    #setRetroArchCoreOption "${dir_name}yabasanshiro_multitap_port1" "disabled"
    #setRetroArchCoreOption "${dir_name}yabasanshiro_multitap_port2" "disabled"
    #setRetroArchCoreOption "${dir_name}yabasanshiro_resolution_mode" "2x"
    #setRetroArchCoreOption "${dir_name}yabasanshiro_sh2coretype" "dynarec"
    #setRetroArchCoreOption "${dir_name}yabasanshiro_videoformattype" "NTSC"
}
