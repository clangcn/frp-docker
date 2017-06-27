# 一、frps for Docker
##1、介绍
基于Dockerfile文件编译出一个frps的容器镜像。

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
wget --no-check-certificate https://github.com/clangcn/frp-docker/raw/master/frps-docker/frps-docker.tar
```

镜像导入命令
```bash
docker load < frps-docker.tar
```

# 三、使用
##启动命令
```bash
docker run -h="frps-docker" --name frps-docker -d \
-e set_bind_port=5443 \
-p 5443:5443 \
-e set_dashboard_port=6443 \
-p 6443:6443 \
-e set_vhost_http_port=80 \
-p 80:80 \
-e set_vhost_https_port=443 \
-p 443:443 \
-e set_privilege_token=password \
-e set_max_pool_count=50 \
-e str_log_level=info \
-e set_log_max_days=3 \
"frps-docker:latest"
```
---
##变量说明（变量名区分大小写）

| 变量名 | 默认值  | 描述 |
| :------------------- |:-----------:| :------------------------------------- |
| set_bind_port        | 5443        | frps服务端口，用于客户端连接               |
| set_vhost_http_port  | 80          | 默认http穿透的端口。                     |
| set_vhost_https_port | 443         | 默认https穿透服务的端口                   |
| set_privilege_token  | password    | frps的特权密码，用于客户端连接             |
| set_max_pool_count   | 50          | 最大连接池数，貌似不用这个了                |
| str_log_level        | info        | 日志等级，可选项：debug, info, warn, error |
| set_log_max_days     | 3           | 日志保存天数，默认保存3天的                 |

