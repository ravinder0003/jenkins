#!/bin/bash

username=ravinder

# Assign values to parameters used in Script from Jenkins Job parameters
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

# Force Sync Repo
repo sync -f --force-sync --no-clone-bundle -j8

rm -rf vendor/xiaomi
rm -rf kernel/xiaomi/msm8953
rm -rf device/xiaomi/msm8953-common
rm -rf device/xiaomi/tissot

git clone https://gitlab.com/ravinder0003/vendor-xiaomi-tissot.git vendor/xiaomi
git clone https://gitlab.com/ravinder0003/device-xiaomi-msm8953-common.git device/xiaomi/msm8953-common
git clone https://gitlab.com/ravinder0003/kernel_xiaomi_msm8953.git -b lineage-15.1_clang kernel/xiaomi/msm8953
git clone https://gitlab.com/ravinder0003/device-xiaomi-tissot.git -b rr device/xiaomi/tissot

# RR specific
export days_to_log=1
export WITH_ROOT_METHOD="rootless"
export RR_BUILDTYPE=Unofficial

# Build ROM
source build/envsetup.sh
lunch rr_"$device"-userdebug
make bacon -j8
