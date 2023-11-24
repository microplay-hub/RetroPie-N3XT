#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-vice"
rp_module_desc="C64 / C128 / PET / Plus4 / VIC20 emulator - port of VICE for libretro"
rp_module_help="ROM Extensions: .cmd .crt .d64 .d71 .d80 .d81 .g64 .m3u .prg .t64 .tap .x64 .zip .vsf\n\nCopy your games to $romdir/c64"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/vice-libretro/master/vice/COPYING"
rp_module_repo="git https://github.com/libretro/vice-libretro.git master"
rp_module_section="opt"
rp_module_flags=""

function _get_targets_lr-vice() {
    echo x64 x64dtv x64sc x128 xpet xplus4 xvic
}

function sources_lr-vice() {
    gitPullOrClone
}

function build_lr-vice() {
    mkdir -p "$md_build/cores"
    local target
    for target in $(_get_targets_lr-vice); do
        make clean
        make EMUTYPE="$target"
        cp "$md_build/vice_${target}_libretro.so" "cores/"
        md_ret_require+=("$md_build/cores/vice_${target}_libretro.so")
    done
}

function install_lr-vice() {
    md_ret_files=(
        'vice/data'
        'vice/COPYING'
    )
    local target
    for target in $(_get_targets_lr-vice); do
        md_ret_files+=("cores/vice_${target}_libretro.so")
    done
}

function configure_lr-vice() {
    mkRomDir "c64"
    mkRomDir "c128"
    mkRomDir "pet"
    mkRomDir "plus4"
    mkRomDir "vic20"
    ensureSystemretroconfig "c64"
    ensureSystemretroconfig "c128"
    ensureSystemretroconfig "pet"
    ensureSystemretroconfig "plus4"
    ensureSystemretroconfig "vic20"

    addEmulator 1 "$md_id" "c64" "$md_inst/vice_x64_libretro.so"
    addEmulator 1 "$md_id" "c64dtv" "$md_inst/vice_x64dtv_libretro.so"
    addEmulator 1 "$md_id" "c64sc" "$md_inst/vice_x64sc_libretro.so"
    addEmulator 1 "$md_id" "c128" "$md_inst/vice_x128_libretro.so"
    addEmulator 1 "$md_id" "pet" "$md_inst/vice_xpet_libretro.so"
    addEmulator 1 "$md_id" "plus4" "$md_inst/vice_xplus4_libretro.so"
    addEmulator 1 "$md_id" "vic20" "$md_inst/vice_xvic_libretro.so"
    
    addSystem "c64"
    addSystem "c64dtv"
    addSystem "c64sc"
    addSystem "c128"
    addSystem "pet"  
    addSystem "plus4"
    addSystem "vic20"

    [[ "$md_mode" == "remove" ]] && return

    if isPlatform "arm"; then
        setRetroArchCoreOption "vice_sid_engine" "FastSID"
        isPlatform "armv6" && setRetroArchCoreOption "vice_sound_sample_rate" "22050"
    fi

    cp -R "$md_inst/data" "$biosdir"
    chown -R $user:$user "$biosdir/data"
}
