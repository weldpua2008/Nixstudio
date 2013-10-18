#!/bin/bash
PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin"
export PATH
XDIALOG_HIGH_DIALOG_COMPAT=1
export XDIALOG_HIGH_DIALOG_COMPAT
LC_ALL="ru_RU.KOI8-R"
export LC_ALL

[ "`id -u`" != "0" ] && exec sudo "$0" "$@"
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15
DIALOG="dialog"
[ -n "$DISPLAY" ] && [ -x /usr/bin/Xdialog ] && DIALOG="Xdialog"


P="/tmp/mony.ppp"

t=1

PID=/var/lock/megalan.pid

show_m(){
inf=`ifconfig |grep 'ppp'|awk '{print $1}'|tr '\n' ' ' `
#touch $P
#�������� ����� ���������� �� ������� ������
#ifconfig $inf|grep 'TX bytes:'|awk '{print$2}'|tr 'bytes:' '-'
#ifconfig $inf|grep 'TX bytes:'|awk '{print$6}'|tr 'bytes:' ' '
#��� � ������ !!!


tr_in1=`ifconfig $inf|grep 'RX bytes:'|awk '{print$3}'`
tr_in2=`ifconfig $inf|grep 'RX bytes:'|awk '{print$4}'`
tr_in="$tr_in1$tr_in2"
echo "in:$tr_in"
tr_o1=`ifconfig $inf|grep 'RX bytes:'|awk '{print$7}'`
tr_o2=`ifconfig $inf|grep 'RX bytes:'|awk '{print$8}'`
tr_o="$tr_o1$tr_o2"
echo "out:$tr_o"
$DIALOG --title "Status:" --msgbox "�� ������� Download:$tr_in \n ��������� Upload: $tr_o "  10 25

}
close_inet(){
show_m
sleep 1
rm $PID
poff megalan
killall knetstats
sleep 2
}
rout(){
sleep 1
pp=`ifconfig |grep 'ppp'|awk '{print $1}'|tr '\n' ', ' `
echo $pp>$PID
make_knetstats.sh
route delete default
sleep 1
route add default $def;
knetstats&
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
#$DIALOG --no-buttons --title "����������� � ���������" --infobox   "���������� ������������ $t ������."  10 25 0
f
	case $t in
  	60)
$DIALOG --title "����������� � ���������" --msgbox "���������� ������������ $t ������. ��������� ��� ���������."  10 25
	exit
	;;
	esac
;;
esac

}

up_inet(){
touch $PID
pon megalan
#sleep 5
#sleep 5
def=`ifconfig |grep 'ppp'|awk '{print $1}'`
a=`echo $def|awk '{print $1}'`
f
}


mes1="��������:"
if [   -f $PID ]; then
mes3="down"
mes4="��������� ��������"
mes21="reconect"
mes22="��������������� "
$DIALOG --clear --title "������ �����������:" --menu "$mes" 20 51 4 "up" "����������� � ��������" "$mes3" "$mes4" "$mes21" "$mes22" 2> $tempfile
fi
if [ !   -f $PID ]; then
$DIALOG --clear --title "������ �����������:" --menu "$mes" 20 51 4 "up" "����������� � ��������" 2> $tempfile
fi

retval=$?
choice=`cat $tempfile`

case $retval in
  0)
case $choice in
up)
up_inet
if [  -f $PID ]; then
$DIALOG --title "����������� � ���������" --msgbox "�������� ������� ���������"  10 25
fi
;;
down)
close_inet
if [ ! -f $PID ]; then
$DIALOG --title "����������� � ���������" --msgbox "�������� ������� ��������"  10 25
fi
;;
reconect)
close_inet
up_inet
if [  -f $PID ]; then
$DIALOG --title "����������� � ���������" --msgbox "�������� ������� �����������"  10 25
fi
;;
esac
;;
1)
  exit
esac

