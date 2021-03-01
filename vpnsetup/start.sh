#!/bin/bash


#echo "ip addr show eth0"
#ip addr show eth0

HOME_WORKDIR=/root/vpnsetup
HOME_VPNCONFIG=$HOME_WORKDIR/vpnconfig
HOME_VPNCONFIGEXAMPLE=$HOME_WORKDIR/vpnconfigexample

for i in README start.sh.example server.conf.example server.conf.example2 openssl.cfg.example client.conf.example
do

if [ ! -e "$HOME_VPNCONFIG/$i" ]
then
    echo "recreating $HOME_VPNCONFIG/$i"
    cp "$HOME_VPNCONFIGEXAMPLE/$i" "$HOME_VPNCONFIG"
fi

done

if [ ! -e "$HOME_VPNCONFIG/start.sh" ]
then
    echo "$HOME_VPNCONFIG/start.sh doest't exists - read README file"
    exit 1
fi

cd "$HOME_VPNCONFIG"

echo "running $HOME_VPNCONFIG/start.sh"
bash "$HOME_VPNCONFIG/start.sh"
