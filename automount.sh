#!/bin/bash
# Generate an automounter entry automatically
# for automount /mnt/auto program this_script
# (C) Klaus Knopper 2002
# WARNING: This script is used for removable media in KNOPPIX,
# therefore the mount is always read-write (except for cdroms
# and ntfs).
#change by wel: weldpua2008@ukr.net
#/etc/
# Defaults
rw="rw"
device="/dev/${1##*/}"
case "$1" in
floppy)     [ -s /etc/sysconfig/floppy ] || exit 1; device="/dev/fd0";;
cdrom*)     rw="ro";;
dvd*)       rw="ro";;
esac

# Uses external fstype script from scanpartitions-knoppix
fs="$(fstype "$device")"

[ "$?" = "0" ] || exit 1

case $CHARSET in
koi8-r)echo "CHARSET $CHARSET"
;;
cp1251)echo "CHARSET $CHARSET"
;;
utf)echo "CHARSET $CHARSET"
;;
utf-8)echo "CHARSET $CHARSET"
;;
*)
CHARSET=`cat /etc/sysconfig/i18n|grep 'CHARSET'|tr '"' ' '|awk '{print$2}'`
;;
esac

case "$fs" in
*fat|msdos) options="${rw},uid=knoppix,gid=knoppix,umask=000,codepage=866,iocharset=${CHARSET}";;
ntfs)       options="ro,uid=knoppix,gid=knoppix,umask=0222,nls=${CHARSET}";;
iso9660)    options="ro";;
*)          options="${rw}";;
esac

MNTLINE="-fstype=$fs,users,exec,$options	:$device"

# Return line to the automounter
echo "$MNTLINE"
