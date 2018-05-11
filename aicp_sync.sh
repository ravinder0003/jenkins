#!/bin/bash

username=ravinder

mkdir aicp
cd aicp

repo init -u https://github.com/AICP/platform_manifest.git -b o8.1
repo sync -f --force-sync --no-clone-bundle -j8

git clone https://gitlab.com/ravinder0003/vendor-xiaomi-tissot.git vendor/xiaomi
git clone https://gitlab.com/ravinder0003/kernel_xiaomi_msm8953.git kernel/xiaomi/msm8953
git clone https://gitlab.com/ravinder0003/device-xiaomi-msm8953-common.git device/xiaomi/msm8953-common
git clone https://gitlab.com/ravinder0003/device-xiaomi-tissot.git -b aicp device/xiaomi/tissot

curl https://raw.githubusercontent.com/ravinder0003/jenkins/master/build_aicp.sh > build_aicp.sh
