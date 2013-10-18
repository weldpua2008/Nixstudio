#!/bin/bash
ifconfig eth0 192.168.10.2
route add -net 192.168.128.0/24 gw 192.168.10;
route add -net 10.0.0.0/8 gw 192.168.10.1
