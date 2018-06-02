#!/bin/bash

username=ravinder

device="$1"

make clean && make clobber
export USE_CCACHE=1
export CCACHE_DIR=/home/ccache/$username
prebuilts/misc/linux-x86/ccache/ccache -M 50G

# Force Sync Repo
repo sync -f --force-sync --no-clone-bundle -j8

rm -rf vendor/xiaomi/whyred
rm -rf kernel/xiaomi/whyred
rm -rf device/xiaomi/whyred

git clone https://github.com/Whyred-Development/vendor_xiaomi_whyred.git vendor/xiaomi/whyred
git clone https://github.com/Whyred-Development/kernel_xiaomi_whyred.git kernel/xiaomi/whyred
git clone https://gitlab.com/ravinder0003/device_xiaomi_whyred.git -b cos device/xiaomi/whyred

# Build ROM
. build/envsetup.sh
lunch cos_"$device"-userdebug
brunch "$device"
