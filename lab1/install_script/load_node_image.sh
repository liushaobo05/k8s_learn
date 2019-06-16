#!/bin/bash

KUBE_VERSION=v1.14.3
KUBE_PAUSE_VERSION=3.1

images=(
    kube-proxy:${KUBE_VERSION}
    pause:${KUBE_PAUSE_VERSION}
)

for imageName in ${images[@]} ; do
    docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName
    docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName k8s.gcr.io/$imageName
    docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName
done

