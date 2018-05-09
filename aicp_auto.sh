#!/bin/bash

username=ravinder

use_ccache="$1"
make_clean="$2"
device="$3"

# Colors makes things beautiful

export TERM=xterm

    red=$(tput setaf 1)             #  red
    grn=$(tput setaf 2)             #  green
    blu=$(tput setaf 4)             #  blue
    cya=$(tput setaf 6)             #  cyan
    txtrst=$(tput sgr0)             #  Reset

# CCACHE UMMM!!! Cooks my builds fast

if [ "$use_ccache" = "yes" ];
then
echo -e ${blu}"CCACHE is enabled for this build"${txtrst}
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
echo -e ${grn}"CCACHE Cleared"${txtrst};
fi

# Its Clean Time
if [ "$make_clean" = "yes" ];
then
make clean && make clobber
wait
echo -e ${cya}"OUT dir from your repo deleted"${txtrst};
fi

# Syncing AICP repo
repo init -u https://github.com/AICP/platform_manifest.git -b o8.1
repo sync -f --force-sync --no-clone-bundle

# Cloning trees, vendor and kernel
git clone https://github.com/AICP-Tissot/vendor-xiaomi-tissot.git vendor/xiaomi
git clone https://github.com/AICP-Tissot/kernel_xiaomi_msm8953.git kernel/xiaomi/msm8953
git clone https://github.com/AICP-Tissot/device-xiaomi-msm8953-common.git device/xiaomi/msm8953-common
git clone https://github.com/AICP-Tissot/device-xiaomi-tissot.git -b aicp device/xiaomi/tissot

# Build ROM
source build/envsetup.sh
lunch aicp_"$device"-userdebug
make bacon -j8
