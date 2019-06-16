#!/bin/bash

set -e

# Uninstall old versions
apt-get remove docker docker-engine docker.io containerd runc

# Set up repository
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Use Aliyun Docker
curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository \
     "deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu \
     $(lsb_release -cs) \
     stable"


# Install a validated docker version
# 安装最新版ce版docker
apt-get install -y docker-ce

# 配置国内镜像源
mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://5twf62k1.mirror.aliyuncs.com"]
}
EOF

systemctl daemon-reload
systemctl restart docker

docker version
