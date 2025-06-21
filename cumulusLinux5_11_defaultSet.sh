#!bin/bash
#CUMULUS-AUTOPROVISIONING

HOSTNAME=$(hostname)
IP=$(ip -o -f inet addr show eth0 | awk '{print $4}')
GW=$(ip route show vrf mgmt | ask '/^default via/ {print $3})
PLATFORM=$(nv show platform)
INFO="Hostname: $HOSTNAME, IP: $IP, GW: $GW, PLATFORM: $PLATFORM)"

echo "$INFO" > /home/cumulus/INFO.txt
echo "Device Information has been written to the ZTP log." | tee -a /var/log/ztp.log

nv set system aaa user cumulus password 'abc!123'
#nv set interface swp1-64 link breakout 2x
#nv set interface swp1-64s0-1 link state up
nv set interface eth0 ip address $IP
nv set interface eth0 ip gateway $GW
nv unset interface eth0 ip address dhcp
nv config apply -y
nv config save

echo "ZTP script completed successfully." | tee -a /var/log/ztp.log