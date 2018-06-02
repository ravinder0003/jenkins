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

rm -rf vendor/xiaomi/whyred
rm -rf kernel/xiaomi/whyred
rm -rf device/xiaomi/whyred

git clone https://github.com/Whyred-Development/vendor_xiaomi_whyred.git vendor/xiaomi/whyred
git clone https://github.com/Whyred-Development/kernel_xiaomi_whyred.git kernel/xiaomi/whyred
git clone https://gitlab.com/ravinder0003/device_xiaomi_whyred.git -b aosip device/xiaomi/whyred

# Build ROM
. build/envsetup.sh
lunch aosip_"$device"-userdebug
time mka kronic
