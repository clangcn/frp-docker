# 一、frps for Docker
##1、介绍
基于Dockerfile文件编译出一个frps的容器镜像。

##2、版本
[frp 0.20.0](https://github.com/fatedier/frp/releases/latest)

##3、问题
如何安装Docker
自定百度吧，方法太多了

# 二、安装
##下载镜像导入
从项目中下载docker images后导入，阿里云镜像下载：
```bash
wget --no-check-certificate https://code.aliyun.com/clangcn/frp-docker/raw/master/frps-docker/frps-docker.tar
```

github镜像下载地址：
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
-p 6443:5443/tcp \
-p 6443:5443/udp \
-p 6444:5444/udp \
-p 7443:5445/tcp \
-p 8080:80/tcp \
-p 8443:443/tcp \
-e set_token=password \
-e set_subdomain_host= \
-e set_max_pool_count=50 \
-e str_log_level=info \
-e set_log_max_days=3 \
"frps-docker:latest"
```
---
##端口说明

| Docker内定义 | Docker内默认值  | 描述 |
| :------------------- |:-----------:| :------------------------------------- |
| bind_port        | 5443(TCP)        | frps服务端口                           |
| kcp_bind_port    | 5443(UDP)        | KCP加速端口                            |
| bind_udp_port    | 5444(UDP)        | udp端口帮助udp洞洞穿nat                 |
| dashboard_port   | 5445(TCP)        | Frps控制台端口                         |
| vhost_http_port  | 80(TCP)          | http穿透的端口。                        |
| vhost_https_port | 443(TCP)         | https穿透服务的端口                     |

---
##变量说明（变量名区分大小写）

| 变量名 | 默认值  | 描述 |
| :------------------- |:-----------:| :------------------------------------------------ |
| set_token            | password    | frps的特权密码，用于客户端连接                         |
| set_subdomain_host   |             | frps子域名设置，默认为空，可以输入类似abc.com这样的域名   |
| set_max_pool_count   | 50          | 最大连接池数，貌似不用这个了                           |
| str_log_level        | info        | 日志等级，可选项：debug, info, warn, error           |
| set_log_max_days     | 3           | 日志保存天数，默认保存3天的                            |

