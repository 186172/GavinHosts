#!/bin/sh
echo "#########################"
echo "# 过程可能较慢，请耐心等待 "
echo "#########################"
touch /tmp/GavinHosts.txt.tmp
until [ "`cat /tmp/GavinHosts.txt.tmp|grep -c GavinHosts`" != 0 ];do
	sleep 15
	wget http://hosts.gav1n.com/GavinHosts.txt -O /tmp/GavinHosts.txt.tmp
done
mv /tmp/GavinHosts.txt.tmp /jffs/hosts/GavinHosts.txt
stopservice dnsmasq && startservice dnsmasq
