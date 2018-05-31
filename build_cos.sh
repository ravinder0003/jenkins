#!/bin/bash

username=ravinder

device="$1"

# Force Sync Repo
# repo sync -f --force-sync --no-clone-bundle -j8
# make clobber

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
