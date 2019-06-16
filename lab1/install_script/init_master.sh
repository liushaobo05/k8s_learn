#!/bin/bash

# Reset firstly if ran kubeadm init before
kubeadm reset -f

# kubeadm init with flannel network
kubeadm init --kubernetes-version=v1.14.3 --pod-network-cidr=10.244.0.0/16

mkdir -p $HOME/.kube
cp /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
source $HOME/.bash_profile


token=$(kubeadm token list | grep -v TOKEN | cut -d" " -f 1)
ca_token=$(openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //')
