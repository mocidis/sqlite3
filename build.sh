#!/bin/bash
#define constant variable
LINUX_ARMV7L=$PWD/../libs/linux-armv7l
LINUX_X86_64=$PWD/../libs/linux-x86_64
LINUX_I686=$PWD/../libs/linux-i686
MINGW=$PWD/../libs/mingw32-i586
MACOS=$PWD/../libs/darwin-x86_64

#MACOS
uname -a | grep "Darwin"
if [ $? == 0 ]; then
	INSTALL_DIR=$MACOS
fi
#MINGW
uname -a | grep "MINGW32"
if [ $? == 0 ]; then
	INSTALL_DIR=$MINGW
fi
#Linux
uname -a | grep "Linux"
if [ $? == 0 ]; then
	ARCHITECTURE=`uname -m`
	if [ $ARCHITECTURE = "i686" ]; then
		INSTALL_DIR=$LINUX_I686
	elif [ $ARCHITECTURE = "x86_64" ]; then
		INSTALL_DIR=$LINUX_X86_64
	fi
fi

echo $INSTALL_DIR
#build for arm first
make distclean
#./configure --host=arm-linux-gnueabi --enable-shared=no --enable-static --prefix=$LINUX_ARMV7L
./configure --host=arm-linux-gnueabihf --prefix=$LINUX_ARMV7L
make
make install

#build for intel
make distclean
#./configure --enable-shared=no --enable-static --prefix=$INSTALL_DIR
./configure --prefix=$INSTALL_DIR
make
make install
