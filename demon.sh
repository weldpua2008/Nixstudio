#!/bin/bash
PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin"
export PATH
[ "`id -u`" != "0" ] && exec sudo "$0" "$@"
PID=/var/lock/saltov.pid

con_(){
rout(){
sleep 1
pp=`ifconfig |grep 'ppp'|awk '{print $1}'|tr '\n' ', ' `
echo $pp>$PID
#make_knetstats.sh
route delete default
sleep 1
route add default $def;
#knetstats&
echo $def>$PID
}
f(){
case $a in
ppp0)
rout
;;
ppp1)
rout
;;
ppp2)
rout
;;
ppp3)
rout
;;
ppp4)
rout
;;
*)
sleep 1
t=`expr $t + 1`
def=`ifconfig |grep 'ppp'|awk '{print $1}'`
a=`echo $def|awk '{print $1}'`
f
	case $t in
  	10)sleep 2;;
	30)sleep 5;;
	60)
	sleep 20
	t="0"
	;;
	esac
;;
esac

}
f
}


f_(){
rout_(){
echo "Connection lost!!!"
pon saltov
#def=`ifconfig |grep 'ppp'|awk '{print $1}'`
#a=`echo $def|awk '{print $1}'`
sleep 1
con_
sleep 1
f_
}
a1=`cat $PID`
inf=`ifconfig |grep 'ppp'|awk '{print $1}'|tr '\n' ' ' `
#echo "$inf"
#inf=sdsa
if [  "$a1 " != "$inf" ]; then 
#####
#Запускается, если у НАС разрыв соеденения!!!
#####
#echo "$inf|"
#echo "$a|"
	case $a1 in
	ppp0)
	rout_
	;;
	ppp1)
	rout_
	;;
	ppp2)
	rout_
	;;
	ppp3)
	rout_
	;;
	ppp4)
	rout_
	;;
	*)
	sleep 1
	f
	;;
	esac
else
echo "Connected"
sleep 5
f_
fi
}
f_
