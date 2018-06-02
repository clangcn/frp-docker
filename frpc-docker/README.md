# 一、frpc for Docker
##1、介绍
基于Dockerfile文件编译出一个frpc的容器镜像。

##2、版本
[frp 0.20.0](https://github.com/fatedier/frp/releases/latest)

##3、问题
如何安装Docker
自行百度吧

# 二、安装
##下载镜像导入
从项目中下载docker images后导入，阿里云镜像下载：
```bash
wget --no-check-certificate https://code.aliyun.com/clangcn/frp-docker/raw/master/frpc-docker/frpc-docker.tar
```

github镜像下载地址：
```bash
wget --no-check-certificate https://github.com/clangcn/frp-docker/raw/master/frpc-docker/frpc-docker.tar
```

镜像导入命令
```bash
docker load < frpc-docker.tar
```

# 三、使用
##启动命令
###需要将你本地的frpc.ini配置文件映射到docker里，frpc.ini示例：

阿里云下载地址：
```bash
wget --no-check-certificate https://code.aliyun.com/clangcn/frp-docker/raw/master/frpc-docker/frpc.ini -O ~/frpc.ini
```

github下载地址：
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

