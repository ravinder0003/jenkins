#!/bin/bash

# make clean && make clobber

# Force Sync Repo
# repo sync -f --force-sync --no-clone-bundle -j8

# rm -rf vendor/xiaomi/whyred
# rm -rf kernel/xiaomi/whyred
# rm -rf device/xiaomi/whyred

git clone https://gitlab.com/ravinder0003/proprietary_vendor_xiaomi.git vendor/xiaomi
git clone https://gitlab.com/ravinder0003/kernel_xiaomi_sdm660.git kernel/xiaomi/sdm660
git clone https://gitlab.com/ravinder0003/device_xiaomi_whyred.git -b aex device/xiaomi/whyred

# Build ROM
. build/envsetup.sh
lunch aosp_whyred-userdebug
mka aex -j8
