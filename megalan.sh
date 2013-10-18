#!/bin/bash
#������ ���������� wel ��� GNU/Linux, Knoppix
#������ ����������� � ��������� � �������� "���� ����"- "Saltov.Net"
#
PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin"
export PATH
XDIALOG_HIGH_DIALOG_COMPAT=1
export XDIALOG_HIGH_DIALOG_COMPAT
LC_ALL="ru_RU.KOI8-R"
export LC_ALL
[ "`id -u`" != "0" ] && exec sudo "$0" "$@"
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
TMP=$tempfile
trap "rm -f $tempfile" 0 1 2 5 15
DIALOG="dialog"
[ -n "$DISPLAY" ] && [ -x /usr/bin/Xdialog ] && DIALOG="Xdialog"

MESSAGE0="��� �������������� ������� ����."
MESSAGE1="���������� �������� ������� ���������� ����� ������� ������ ����������� � PPPoE �������."



bailout(){
rm -f "$TMP"
exit $1
}

[ -f /etc/sysconfig/i18n ] && . /etc/sysconfig/i18n
case "$LANGUAGE" in
ru*)
MESSAGE0="��� �������������� ������� ����."
MESSAGE1="���������� �������� ������� ���������� ����� ������� ������ ����������� � PPPoE �������."
;;

*)
MESSAGE0="No supported network cards found."
MESSAGE1="Please select network device from throught you will connect to PPPoE"
;;
esac


NETDEVICES="$(cat /proc/net/dev | awk -F: '/eth.:|tr.:|wlan.:/{print $1}')"

if [ -z "$NETDEVICES" ]; then
$DIALOG --msgbox "$MESSAGE0" 15 45
bailout
fi

count="$(echo "$NETDEVICES" | wc -w)"

if [ "$count" -gt 1 ]; then
DEVICELIST=""
for DEVICE in $NETDEVICES; do DEVICELIST="$DEVICELIST ${DEVICE} Network_card_${DEVICE##eth}"; done
rm -f "$TMP"
$DIALOG --menu "$MESSAGE1" 18 45 12 $DEVICELIST 2>"$TMP" || bailout
read DV <"$TMP" ; rm -f "$TMP"
else
DV="$(echo $NETDEVICES)"
fi
ifconfig $DV up 

mes="������� ��� ����� ��� ����������� � Intrnet\n
Enter your login for connect to Intrnet:"
$DIALOG --title "���� ������" --inputbox "$mes" 20 30 2> $tempfile
retval=$?
case $retval in
  0)
    #echo "�� ����� `cat $tempfile`"
	name=`cat $tempfile`
	$DIALOG --title "�� �����" --msgbox "$name"  10 25
   ;;
  1)
$DIALOG --title "����� �� �����" --msgbox "����� �� �����"  10 25
exit
;;

  255)
    if test -s $tempfile ; then
      cat $tempfile
    else
	$DIALOG --title "����� �� �����" --msgbox "����� �� �����\n������ ������� ESC."  10 25
	exit
	#exit
    fi
    ;;
esac


echo "noipdefault
usepeerdns
defaultroute
hide-password
lcp-echo-interval 20
lcp-echo-failure 3
connect /bin/true
noauth
persist
mtu 1492
noaccomp
default-asyncmap
plugin rp-pppoe.so $DV
user "$name"

">/etc/ppp/peers/megalan

echo "asyncmap 0
noauth
crtscts
lock
hide-password
modem
noipdefault
passive
proxyarp
lcp-echo-interval 30
lcp-echo-failure 4
noipx

">/etc/ppp/options

mes="Enter your password for connect to Intrnet\n
������� ��� ������ ��� ����������� � Intrnet"

$DIALOG --title "���� ������" -passwordbox "$mes" 20 30 2> $tempfile
retval=$?
case $retval in
  0)
    #echo "�� ����� `cat $tempfile`"
	pass=`cat $tempfile`
	#$DIALOG --title "�� �����" --msgbox "$name"  10 25
   ;;
  1)
	$DIALOG --title "����� �� �����" --msgbox "����� �� �����"  10 25
	exit
;;
  255)
    if test -s $tempfile ; then
      cat $tempfile
    else
      $DIALOG --title "����� �� �����" --msgbox "����� �� �����\n������ ������� ESC."  10 25
	exit
    fi
    ;;
esac

mes="�� ������: ��������(YES) ���������� ���  ����������(NO) ��� ���� � ��������?\n Do you want add(YES) or  rewrite(NO) your information in secret file?"

$DIALOG --title " ������" --clear --yesno "$mes" 10 40
case $? in
    0)
echo "\"$name\" *    \"$pass\"
">>/etc/ppp/chap-secrets   
;;
1)
echo "\"$name\" *    \"$pass\"
">/etc/ppp/chap-secrets   
;;
255)
echo "������ ������� ESC.";;
esac













