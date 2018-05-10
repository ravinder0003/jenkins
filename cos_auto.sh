#!/bin/bash

username=ravinder

# Syncing CosmicOS repo
repo init -u https://github.com/Cosmic-OS/platform_manifest.git -b oreo-mr1
repo sync -f --force-sync --no-clone-bundle

# Cloning trees, vendor and kernel
git clone https://github.com/AICP-Tissot/vendor-xiaomi-tissot.git vendor/xiaomi
git clone https://github.com/AICP-Tissot/kernel_xiaomi_msm8953.git kernel/xiaomi/msm8953
git clone https://github.com/AICP-Tissot/device-xiaomi-msm8953-common.git device/xiaomi/msm8953-common
git clone https://github.com/AICP-Tissot/device-xiaomi-tissot.git -b cos device/xiaomi/tissot

# Build ROM
source build/envsetup.sh
lunch cos_tissot-userdebug
make bacon -j8