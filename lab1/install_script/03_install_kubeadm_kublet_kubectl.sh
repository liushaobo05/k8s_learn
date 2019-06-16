#!/bin/bash

# 配置阿里源
cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://mirrors.ustc.edu.cn/kubernetes/apt kubernetes-xenial main
EOF

gpg --keyserver keyserver.ubuntu.com --recv-keys BA07F4FB
gpg --export --armor BA07F4FB | sudo apt-key add -

apt-get update
apt-get install -y kubelet kubeadm kubectl

systemctl daemon-reload
systemctl restart kubelet
