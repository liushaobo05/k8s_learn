#!/bin/bash

kubeadm join master:6443 --token $token --discovery-token-ca-cert-hash sha256:$ca_token



