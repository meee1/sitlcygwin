#!/bin/bash

export PATH="/usr/local/bin:/usr/bin:/bin"
export PATH

set -x

cd /cygdrive/c/work/ardupilot/

git reset --hard origin/master
git clean -f
git checkout -f master 2>&1
git pull
git submodule update --init --recursive -f

# build for 32 bit target
CXX=i686-pc-cygwin-g++.exe CC=i686-pc-cygwin-gcc ./waf configure --board sitl

/usr/bin/python waf -j4 copter
/usr/bin/python waf -j4 plane
/usr/bin/python waf -j4 rover
/usr/bin/python waf -j4 heli

cp /cygdrive/c/work/ardupilot/build/sitl/bin/ardurover.exe /cygdrive/c/work/sitl/APMrover2.elf
cp /cygdrive/c/work/ardupilot/build/sitl/bin/arduplane.exe /cygdrive/c/work/sitl/ArduPlane.elf
cp /cygdrive/c/work/ardupilot/build/sitl/bin/arducopter.exe /cygdrive/c/work/sitl/ArduCopter.elf
cp /cygdrive/c/work/ardupilot/build/sitl/bin/arducopter-heli.exe /cygdrive/c/work/sitl/ArduHeli.elf

strip /cygdrive/c/work/sitl/APMrover2.elf
strip /cygdrive/c/work/sitl/ArduPlane.elf
strip /cygdrive/c/work/sitl/ArduCopter.elf
strip /cygdrive/c/work/sitl/ArduHeli.elf

cp /usr/i686-pc-cygwin/sys-root/usr/bin/*.dll /cygdrive/c/work/sitl/

cd /cygdrive/c/work/sitl/
ls
