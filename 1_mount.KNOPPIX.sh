#!/bin/bash 
TMP="/tmp/knoppix.tmp"
knoppixDIR="/mnt/hda2/KNOPPI"
knoppixTMPDIR="/mnt/hda2/KnoppixCD"
knoppixISO="knoppix.iso"
knoppix="/$knoppixISO"
#knoppix=`locate $knoppixISO|grep -m 1 $knoppixISO'`
#knoppix=/usr/$knoppixISO
#echo "path to knoppix:$knoppix"
mkdir $knoppixDIR
mkdir $knoppixTMPDIR
mount -o loop $knoppix $knoppixTMPDIR
losetup /dev/loop2 $knoppixTMPDIR/KNOPPIX/KNOPPIX
modprobe cloop file=$knoppixTMPDIR/KNOPPIX/KNOPPIX
mount -t iso9660 /dev/cloop $knoppixDIR/ -o ro,loop
echo "$knoppixDIR">$TMP