#!/bin/bash
TMP=/tmp/knoppix.tmp
knoppixDIR=`cat $TMP`
#echo "$CHROOT/KNOPPIX/">$TMP
cp -Rp install/ $knoppixDIR/tmp/
cp install.sh $knoppixDIR/tmp/install.sh
chmod 755 $knoppixDIR/tmp/install.sh
chroot $knoppixDIR /tmp/install.sh
#chroot $knoppixDIR ls

rm $knoppixDIR/tmp/install.sh