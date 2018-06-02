#!/bin/bash

username=ravinder

mkdir aosip
cd aosip

repo init -u git://github.com/AOSiP/platform_manifest.git -b oreo-mr1
repo sync -f --force-sync --no-clone-bundle -j8

curl https://raw.githubusercontent.com/ravinder0003/jenkins/master/build_aosip.sh > build_aosip.sh
