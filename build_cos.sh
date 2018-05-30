#!/bin/bash

username=ravinder

device="$1"

# Force Sync Repo
repo sync -f --force-sync --no-clone-bundle -j8

rm -rf vendor/xiaomi/whyred
rm -rf kernel/xiaomi/whyred
rm -rf device/xiaomi/whyred

git clone https://github.com/shekhawat2/android_vendor_xiaomi_whyred.git -b o vendor/xiaomi/whyred
git clone https://github.com/shekhawat2/android_kernel_xiaomi_whyred.git -b o kernel/xiaomi/whyred
git clone https://github.com/ravinder0003/android_device_xiaomi_whyred.git -b cos device/xiaomi/whyred

# Build ROM
. build/envsetup.sh
lunch cos_"$device"-userdebug
brunch "$device"
