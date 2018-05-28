#!/bin/bash

username=ravinder

device="$1"

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

make clean && make clobber

# RR specific
export days_to_log=1
export WITH_ROOT_METHOD="rootless"
export RR_BUILDTYPE=Unofficial

# Build ROM
source build/envsetup.sh
lunch rr_"$device"-userdebug
make bacon -j8
