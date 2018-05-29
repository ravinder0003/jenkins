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
git clone https://gitlab.com/ravinder0003/device-xiaomi-tissot.git -b aicp device/xiaomi/tissot

make clobber

# Build ROM
. build/envsetup.sh
lunch cos_"$device"-userdebug
brunch "$device"
