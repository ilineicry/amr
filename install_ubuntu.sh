#!/bin/sh

sudo apt-get update 
sudo apt-get install git python perl -y
sudo apt-get install libssl0.9.8 -y
sudo apt-get install "^libxcb.*" libx11-xcb-dev libglu1-mesa-dev libxrender-dev -y 
sudo apt-get install libatspi-dev -y
sudo apt-get install libdbus-1-dev -y
sudo apt-get install libxext-dev -y

#setup build env
sudo apt-get install build-essential devscripts ubuntu-dev-tools debhelper \
        dh-make diff patch gnupg fakeroot lintian pbuilder -y

cd /home/vagrant

echo 'COMPONENTS="main restricted universe multiverse"' > ~/.pbuilderrc

sudo pbuilder create

#get and build qt

QTBUILD_DIR=`pwd`/qt
INSTALL_ARC=$QTBUILD_DIR/qt-everywhere-opensource-src-5.1.1.tar.gz

mkdir $QTBUILD_DIR
echo $INSTALL_ARC
cd $QTBUILD_DIR

if [ ! -f $INSTALL_ARC ]
then
	wget http://download.qt-project.org/official_releases/qt/5.1/5.1.1/single/qt-everywhere-opensource-src-5.1.1.tar.gz	
	tar -xvf $INSTALL_ARC
fi

cd ./qt-everywhere-opensource-src-5.1.1

sudo ./configure -opensource -qt-libpng -qt-libjpeg -qt-xcb -qt-xkbcommon -no-kms -no-opengl -dbus-linked -openssl-linked -nomake examples -no-javascript-jit -nomake tests -confirm-license

sudo make
sudo make install

export PATH=$PATH:/usr/local/Qt-5.1.1/bin