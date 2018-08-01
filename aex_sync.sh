#!/bin/bash

mkdir aex
cd aex

repo init -u git://github.com/AospExtended/manifest.git -b 8.1.x
repo sync -f --force-sync --no-clone-bundle -j8

curl https://raw.githubusercontent.com/ravinder0003/jenkins/master/aex_build.sh > aex_build.sh
