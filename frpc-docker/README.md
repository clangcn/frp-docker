# 一、frpc for Docker
##1、介绍
基于Dockerfile文件编译出一个frpc的容器镜像。

##2、版本
[frp 0.12.0](https://github.com/fatedier/frp/releases/latest)

##3、问题
如何安装Docker

1)官网安装地址
```bash
curl -Lk https://get.docker.com/ | sh
```
2)阿里云安装地址
```bash
curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -
```
RHEL、CentOS、Fedora的用户可以使用`setenforce 0`来禁用selinux以达到解决一些问题

如果你已经禁用了selinux并且使用的是最新版的Docker。

当你在issue 提交问题的时候请注意提供一下信息:
- 宿主机的发行版和版本号.
- 使用 `docker version` 命令来给出Docker版本信息.
- 使用 `docker info` 命令来给出进一步信息.
- 提供 `docker run` 命令的详情 (注意打码你的隐私信息).

# 二、安装
##下载镜像导入
从项目中下载docker images后导入，镜像下载地址：
```bash
wget --no-check-certificate https://github.com/clangcn/frp-docker/raw/master/frpc-docker/frpc-docker.tar
```

镜像导入命令
```bash
docker load < frpc-docker.tar
```

# 三、使用
##启动命令
###需要将你本地的frpc.ini配置文件映射到docker里，frpc.ini示例下载地址：
```bash
wget --no-check-certificate https://github.com/clangcn/frp-docker/raw/master/frpc-docker/frpc.ini -O ~/frpc.ini
```
下载后按照你的服务器提示修改。

修改完成后使用下面命令启动：
```bash
docker run -h="frpc-docker" --name frpc-docker -d \
-v ~/frpc.ini:/usr/local/frpc/frpc.ini \
"frpc-docker:latest"
```
