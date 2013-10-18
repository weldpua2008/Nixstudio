#!/bin/bash
#home="/mnt/hda2/KO/"
#chroot $home
#echo $home
#mount -t proc /proc proc

packege="rpm kdessh"
noru="manpages-de trans-de-en user-de mozilla-firefox-locale-de-de mozilla-thunderbird-locale-de kde-i18n-de mozilla-firefox-locale-de mozilla-firefox-locale-de-de kde-i18n-de kde-i18n-es kde-i18n-fr kde-i18n-it kde-i18n-ja kde-i18n-nl kde-i18n-pl kde-i18n-ru kde-i18n-tr"
openoffice="openoffice-de-en"
game="ace-of-penguins chromium chromium-data"
game4="enigma-data enigma  "
game5="fb-music-low fortune-mod fortunes-min "
game6="frozen-bubble"
game61="frozen-bubble-data"
game7="gtans imaze kasteroids "

game2="katomic kbattleship kreversi ksokoban kteatime ktuberling libkdegames1 netris xbattle xboard xboing xgalaga xskat"
game3=" kmahjongg"
apt-get remove -f -y $noru;
apt-get remove -f -y $openoffice;
apt-get remove -f -y $packege;
apt-get remove -f -y $game
apt-get remove -f -y $game2
apt-get remove -f -y $game3
apt-get remove -f -y $game4
apt-get remove -f -y $game5
apt-get remove -f -y --force-yes $game6
apt-get remove -f -y --force-yes $game61
apt-get remove -f -y $game7
#dpkg -i kde-i18n-ru_3.3.2-1_all.deb