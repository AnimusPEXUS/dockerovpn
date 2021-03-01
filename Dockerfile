FROM fedora

RUN dnf upgrade -y

RUN dnf install -y openvpn
# TODO: migrate to modern packages
RUN dnf install -y bridge-utils
RUN dnf install -y dhcp-client

#RUN ln -s /dev/null /etc/udev/rules.d/80-net-name-slot.rules

RUN mkdir -p /root/vpnsetup

WORKDIR /root/vpnsetup

COPY ./vpnsetup /root/vpnsetup

RUN chmod +x /root/vpnsetup/start.sh

CMD ["bash", "/root/vpnsetup/start.sh"]

EXPOSE 1194
