#!/bin/bash
###
#/etc/init.d/fstab.sh
#/etc/rc.S/S99fstab.sh
#This script's write by wel: weldpua2008@ukr.net
###  It will cheack /etc/fstab, and add line witch help You to view russion name  offile&derictory
##version 3
##must export wright options and detect  vfat systems
tmp="/tmp/fstab.tmp"
fsone(){
dev=`cat /etc/fstab |grep $fs|grep -v '/fd'|awk '{print$1}'|tr '\n' ' '`
devmnt=`cat /etc/fstab |grep $fs|grep -v '/fd'|awk '{print$2}'|tr '\n' ' '`
cat /etc/fstab |grep -v $fs>$tmp
cat $tmp>/etc/fstab
#echo $devmnt
c=`echo $dev|wc -w`
#echo $c
i=0
#echo "$dev"|awk '{print$1}'
b=`expr $c - 1`
CHARSET=`cat /etc/sysconfig/i18n|grep 'CHARSET'|tr '"' ' '|awk '{print$2}'`
#echo $CHARSET
while [ $i -le $b ]
do
i=`expr $i + 1`
#echo $i
hdadev=`echo $dev|awk '{print$'${i}'}'`
hda=`echo $hdadev|tr '/' ' '|awk '{print$2}'`
mnt=`echo $devmnt|awk '{print$'${i}'}'`
#echo $hdadev
case "$fs" in
*fat)options="users,rw,exec,uid=knoppix,gid=knoppix,codepage=866,iocharset=${CHARSET}";;
msdos)options="users,codepage=866,iocharset=${CHARSET}";;
ntfs)options="users,ro,uid=knoppix,gid=knoppix,umask=0222,nls=${CHARSET}";;
 esac
echo "$hdadev $mnt $fs $options	0	0" >>/etc/fstab
done
}
fs="vfat"
fsone
fs="ntfs"
fsone
fs="msdos"
fsone


cheack_auto(){
fs="auto"
#dev=`cat /etc/fstab |grep $fs|grep -v '/fd'|grep -v '/cdrom'|grep -v '/sys'|awk '{print$1}'|tr '\n' ' '`
dev=`cat /etc/fstab |grep $fs|grep -v '/fd'|awk '{print$1}'|tr '\n' ' '`
#devmnt=`cat /etc/fstab |grep $fs|grep -v '/fd'|grep -v '/cdrom'|grep -v '/sys'|awk '{print$2}'|tr '\n' ' '`
devmnt=`cat /etc/fstab |grep $fs|grep -v '/fd'|awk '{print$2}'|tr '\n' ' '`
#echo "$dev"
#echo "$devmnt"
co=`echo "$dev"|wc -w`
#echo "$co"
echo "$dev">$tmp
#cat $tmp
#cat /etc/fstab|grep -v '$dev'
c=`echo $dev|wc -w`
#echo $c
i=0
#echo "$dev"|awk '{print$1}'
b=`expr $c - 1`
CHARSET=`cat /etc/sysconfig/i18n|grep 'CHARSET'|tr '"' ' '|awk '{print$2}'`
#echo $CHARSET

echo "">$tmp
while [ $i -le $b ]
do
i=`expr $i + 1`
#echo $i
hdadev=`echo $dev|awk '{print$'${i}'}'`
hda=`echo $hdadev|tr '/' ' '|awk '{print$2}'`
mnt=`echo $devmnt|awk '{print$'${i}'}'`
fs=`fstype $hdadev`
#echo "$fs"
#echo "$hdadev"



w(){
cat /etc/fstab|grep -v "$hdadev">$tmp
cat $tmp>/etc/fstab
echo "$hdadev $mnt $fs $options	0	0">>/etc/fstab
}

f_disk(){
fd=`fdisk -l |grep $hdadev`
#echo "$fd"

case "$fd" in
*[Ff][Aa][Tt]*)
              #echo "vfat"
options="users,rw,exec,uid=knoppix,gid=knoppix,codepage=866,iocharset=${CHARSET}"
fs="vfat"
w
;;
*[Nn][Tt][Ff][Ss]*)options="users,ro,uid=knoppix,gid=knoppix,umask=0222,nls=${CHARSET}"
fs="ntfs"
w
;;

#*[Ff][Aa][Tt]16*)
              #echo "vfat16";;
 esac
}
case "$fs" in
    fat)    options="users,rw,exec,uid=knoppix,gid=knoppix,codepage=866,iocharset=${CHARSET}"
    w;;
    vfat) options="users,rw,exec,uid=knoppix,gid=knoppix,codepage=866,iocharset=${CHARSET}"
    w;;
    msdos) options="users,codepage=866,iocharset=${CHARSET}"
    w;;
    ntfs)options="users,ro,uid=knoppix,gid=knoppix,umask=0222,nls=${CHARSET}"
    w;;
    auto)
    f_disk
    ;;
 esac
#echo "$hdadev $mnt $fs $options	0	0"
# >>/etc/fstab
done

}
cheack_auto

rm $tmp


