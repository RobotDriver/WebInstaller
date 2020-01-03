#!/usr/bin/env bash
# RobotDriver Install Script
#
# Install with this command (from your Pi):
# curl -L https://install.robotdriver.dev | sudo bash
# Make sure you have `curl` installed
set -eu

INSTALLDIR=/usr/local/robotdriver

if [ $EUID -ne 0 ]
then
 echo "This script must be run as root" 1>&2
 exit 1
fi

#install node
curl -L https://deb.nodesource.com/setup_13.x | sudo -E bash -
sudo apt install nodejs

#install other requirements
apt install -y git gcc g++ make pigpio ffmpeg

rm -rf $INSTALLDIR
mkdir -p $INSTALLDIR
chmod 777 $INSTALLDIR

git clone https://github.com/RobotDriver/RobotDriver $INSTALLDIR

npm config set unsafe-perm true
npm install --prefix $INSTALLDIR

JSDIR=$INSTALLDIR/webroot/inc/js/
LIB=ext-6.6-latest
mkdir -p $JSDIR
curl -L -o $JSDIR$LIB.zip https://install.robotdriver.dev/$LIB.zip
unzip $JSDIR$LIB.zip -d $JSDIR
