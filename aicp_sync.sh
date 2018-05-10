#!/bin/bash

username=ravinder

mkdir aicp
cd aicp

# Syncing CosmicOS repo
repo init -u https://github.com/AICP/platform_manifest.git -b o8.1
repo sync -f --force-sync --no-clone-bundle -j4

# Cloning trees, vendor and kernel
git clone https://github.com/AICP-Tissot/vendor-xiaomi-tissot.git vendor/xiaomi
git clone https://github.com/AICP-Tissot/kernel_xiaomi_msm8953.git kernel/xiaomi/msm8953
git clone https://github.com/AICP-Tissot/device-xiaomi-msm8953-common.git device/xiaomi/msm8953-common
git clone https://github.com/AICP-Tissot/device-xiaomi-tissot.git -b aicp device/xiaomi/tissot
