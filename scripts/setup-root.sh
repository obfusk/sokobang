#!/bin/bash
set -xe
export DEBIAN_FRONTEND=noninteractive
apt-get update || apt-get update
apt-get install -y build-essential git automake
apt-get install -y python3-pip python3-dev libsqlite3-dev
apt-get install -y zlib1g-dev zip unzip pkg-config libffi-dev
apt-get install -y libltdl-dev libssl-dev
if grep -q stretch /etc/os-release; then
  apt-get install -y openjdk-8-jdk-headless
  apt-get install -y lld-7
  ln -fs lld-7 /usr/bin/lld
else
  apt-get remove -y openjdk-8-jdk-headless openjdk-8-jre-headless
  apt-get install -y openjdk-11-jdk-headless
  apt-get install -y lld
fi
