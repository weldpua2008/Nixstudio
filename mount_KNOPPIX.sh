#!/bin/bash 
mkdir /KNOPPIX/ >>/dev/null
mkdir /KnoppixCD/ >>/dev/null
mount -o loop ${1} /KnoppixCD/
losetup /dev/loop2 /KnoppixCD/KNOPPIX/KNOPPIX>>/dev/null
modprobe cloop file=/KnoppixCD/KNOPPIX/KNOPPIX
mount -t iso9660 /dev/cloop /KNOPPIX/ -o ro,loop
