#!/bin/bash

username=ravinder

mkdir test_rr
cd test_rr

repo init -u https://github.com/ResurrectionRemix/platform_manifest.git -b oreo
repo sync -f --force-sync --no-clone-bundle -j8

git clone https://gitlab.com/ravinder_rds/vendor-xiaomi-tissot.git vendor/xiaomi
git clone https://gitlab.com/ravinder_rds/kernel_xiaomi_msm8953.git -b lineage-15.1 kernel/xiaomi/msm8953
git clone https://gitlab.com/ravinder_rds/device-xiaomi-msm8953-common.git device/xiaomi/msm8953-common
git clone https://gitlab.com/ravinder_rds/device-xiaomi-tissot.git -b rr device/xiaomi/tissot

curl https://raw.githubusercontent.com/ravinder0003/jenkins/master/build_rr.sh > build_rr.sh
