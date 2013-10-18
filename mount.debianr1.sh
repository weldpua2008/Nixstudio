#!/bin/bash
mkdir /cd/ >> /dev/null
ln -s /hda6/ISO_/debian-sarge-3.1-r1-i386-binary-2.iso /cd/2.iso>> /dev/null
ln -s /hda6/ISO_/debian-sarge-3.1-r1-i386-binary-1.iso /cd/1.iso>> /dev/null
mkdir /cd/cd1 >> /dev/null
mkdir /cd/cd2 >> /dev/null
umount /cd/cd1
umount /cd/cd2
mount -o loop /cd/1.iso /cd/cd1
mount -o loop /cd/2.iso /cd/cd2


cat /etc/apt/sources.list|grep '#' >/etc/apt/sources.list
echo "deb  file::/cd/cd1/ stable main contrib">>/etc/apt/sources.list
echo "deb  file::/cd/cd2/ stable main contrib">>/etc/apt/sources.list
apt-get update