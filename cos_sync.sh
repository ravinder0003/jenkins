#!/bin/bash

username=ravinder

mkdir cos
cd cos

repo init -u https://github.com/Cosmic-OS/platform_manifest.git -b pulsar-release
repo sync -f --force-sync --no-clone-bundle -j8

curl https://raw.githubusercontent.com/ravinder0003/jenkins/master/build_cos.sh > build_cos.sh
