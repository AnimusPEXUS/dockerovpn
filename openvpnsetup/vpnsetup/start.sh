#!/bin/bash


#echo "ip addr show eth0"
#ip addr show eth0

HOME_WORKDIR=/root/vpnsetup
HOME_VPNCONFIG=$HOME_WORKDIR/vpnconfig
HOME_VPNCONFIGEXAMPLE=$HOME_WORKDIR/vpnconfigexample

for i in README start.sh.example server.conf.example server.conf.example2 openssl.cfg.example
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

mkdir -p /dev/net
mknod /dev/net/tun c 10 200
stat /dev/net/tun

echo "creating tap0"
ip tuntap add dev tap0 mode tap
echo "tap list:"
ip tuntap list

echo "creating bridge"
brctl addbr ovpnbr

echo "adding eth0 to bridge"
brctl addif ovpnbr eth0

echo "adding tap0 to pridge"
brctl addif ovpnbr tap0

echo "removing address from eth0"
ip addr flush dev eth0

#echo "getting address for bridge (using dhcp)"
#dhclient ovpnbr

echo "ip addr:"
ip addr

echo "running $HOME_VPNCONFIG/start.sh"
bash "$HOME_VPNCONFIG/start.sh"
