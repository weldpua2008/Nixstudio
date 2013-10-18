#!/bin/bash
TMP=/tmp/knoppix.tmp
knoppixDIR=`cat $TMP`
CHROOT="/chroot/" #there will be Knoppix Chroot
#rm -Rd $CHROOT
mkdir $CHROOT
cp -Rp $knoppixDIR $CHROOT
echo "$CHROOT/KNOPPIX/">$TMP