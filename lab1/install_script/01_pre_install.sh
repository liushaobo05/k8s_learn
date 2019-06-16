# !/bin/bash

set -e

echo "++++++++++++++++++++++++++++++++++++++++++++"
echo "         statrt "
echo "++++++++++++++++++++++++++++++++++++++++++++"

ehco "please self check selhostname, Mac addr and product_uuid"


echo "++++++++++++++++stop firewall+++++++++++++++"
ufw disable

echo "++++++++++++++++Disable SELinux+++++++++++++"
setenforce 0
cp -p /etc/selinux/config /etc/selinux/config.bak$(date '+%Y%m%d%H%M%S')
sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config

echo "++++++++++++++++Turn off Swap+++++++++++++++"
cp -p /etc/fstab /etc/fstab.bak$(date '+%Y%m%d%H%M%S')
sed -i "s/\/dev\/mapper\/rhel-swap/\#\/dev\/mapper\/rhel-swap/g" /etc/fstab
sed -i "s/\/dev\/mapper\/centos-swap/\#\/dev\/mapper\/centos-swap/g" /etc/fstab
mount -a
free -m
cat /proc/swaps

echo "++++++++++++++++Setup iptables++++++++++++++"
cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-arptables = 1
EOF
sysctl --system

echo "++++++++++++++++++++++++++++++++++++++++++++"
echo "         complete "
echo "++++++++++++++++++++++++++++++++++++++++++++"


