#!/bin/bash

username=ravinder

use_ccache="$1"
make_clean="$2"
device="$3"

# Force Sync Repo
repo sync -f --force-sync --no-clone-bundle -j8

# CCACHE UMMM!!! Cooks my builds fast

if [ "$use_ccache" = "yes" ];
then
export USE_CCACHE=1
export CCACHE_DIR=/home/ccache/$username
prebuilts/misc/linux-x86/ccache/ccache -M 50G
fi

if [ "$use_ccache" = "clean" ];
then
export CCACHE_DIR=/home/ccache/$username
ccache -C
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 50G
wait
fi

# Its Clean Time
if [ "$make_clean" = "yes" ];
then
make clean && make clobber
wait
fi

# Build ROM
source build/envsetup.sh
lunch aicp_"$device"-userdebug
make bacon -j8

gdrive upload out/target/product/$device/aicp_tissot_o-*.zip
