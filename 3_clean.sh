#!/bin/bash
TMP=/tmp/knoppix.tmp
knoppixDIR=`cat $TMP`
#echo "$CHROOT/KNOPPIX/">$TMP
cp clean.sh $knoppixDIR/tmp/clean.sh
chmod 755 $knoppixDIR/tmp/clean.sh
chroot $knoppixDIR /tmp/clean.sh
rm $knoppixDIR/tmp/clean.sh