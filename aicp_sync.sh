#!/bin/bash

username=ravinder

mkdir aicp
cd aicp

repo init -u https://github.com/AICP/platform_manifest.git -b o8.1
repo sync -f --force-sync --no-clone-bundle -j8

curl https://raw.githubusercontent.com/ravinder0003/jenkins/master/build_aicp.sh > build_aicp.sh
