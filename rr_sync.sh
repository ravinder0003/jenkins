#!/bin/bash

username=ravinder

mkdir rr
cd rr

repo init -u https://github.com/ResurrectionRemix/platform_manifest.git -b oreo
repo sync -f --force-sync --no-clone-bundle -j8

curl https://raw.githubusercontent.com/ravinder0003/jenkins/master/build_rr.sh > build_rr.sh
