### 说明
该文档整理了在ubuntu16.4环境下使用kubeadm工具进行k8s集群安装的脚本和步骤整理。
**使用版本v1.14.3进行安装**

构建基础主机环境，可以云主机或，虚拟机
该实验使用vagrant构建创建三台虚拟主机，参考vagrantfile
安装virtualbox，安装vagrant, 参考[vagrant使用教程](https://tangbaoping.github.io/vagrant_doc_zh/v2/)
```
$vagrant up
```

#### 01_pre_install.sh
该脚本用于安装前准备
- 关闭防火墙
- 禁止seLinux
- 关闭swap
- 关闭ipv6

#### 02_install_docker.sh
使用该脚本安装docker, 配置了阿里的安装源，注意修改安装docker版本。

#### load_master_image.sh
该脚本运行的master节点上
由于墙的原因，无法正常下载需要的镜像，使用阿里云docker镜像源下载后，在tag为依赖的docker镜像。
在master节点上运行，下载master运行依赖的组件

#### load_node_image.sh
该脚本运行在node节点上
同上，下载node节点运行的组件docker镜像

#### 03_install_kubeadm_kublet_kubectl.sh
解决墙的下载问题，配置中科大安装镜像源，进行安装，注意修改安装的版本。在安装下载时，会有key校验问题，根据报错信息，修改<code>--recv-keys</code>的值，取提示值的后八位，文档中为<code>BA07F4FB</code>。

#### init_master.sh
启动master节点服务
生成添加node节点的依赖值token, sha256值

#### join_node.sh
添加node节点到集群中
修改token值和sha256值，添加节点


