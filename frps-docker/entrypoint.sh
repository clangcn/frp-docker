#!/bin/bash
#########################################################################
# File Name: frps.sh
# Version:1.3.20180615
# Created Time: 2018-06-15
#########################################################################

set -e
FRPS_BIN="/usr/local/frps/frps"
FRPS_CONF="/usr/local/frps/frps.ini"
FRPS_LOG="/var/log/frps.log"
# ======= FRPS CONFIG ======
set_token=${set_token:-password}                               #token = password
set_subdomain_host=${set_subdomain_host:-}                     #subdomain_host =
set_dashboard_user=${set_dashboard_user:-admin}                #dashboard_user = admin
set_dashboard_pwd=${set_dashboard_pwd:-admin}                  #dashboard_pwd = admin
set_max_pool_count=${set_max_pool_count:-50}                   #max_pool_count = 50
set_max_ports_per_client=${set_max_ports_per_client:-0}        #max_ports_per_client = 0
set_authentication_timeout=${set_authentication_timeout:-900}  #authentication_timeout = 900
set_log_level=${set_log_level:-info}                           #log_level = info
set_log_max_days=${set_log_max_days:-3}                        #log_max_days = 3
set_tcp_mux=${set_tcp_mux:-true}                               #tcp_mux = true

[ ! -f ${FRPS_CONF} ] && cat > ${FRPS_CONF}<<-EOF
# [common] is integral section
[common]
# A literal address or host name for IPv6 must be enclosed
# in square brackets, as in "[::1]:80", "[ipv6-host]:http" or "[ipv6-host%zone]:80"
bind_addr = 0.0.0.0
bind_port = 5443
# udp port to help make udp hole to penetrate nat
bind_udp_port = 5444
# udp port used for kcp protocol, it can be same with 'bind_port'
# if not set, kcp is disabled in frps
kcp_bind_port = 5443
# specify which address proxy will listen for, default value is same with bind_addr
# proxy_bind_addr = 127.0.0.1
# if you want to support virtual host, you must set the http port for listening (optional)
# Note: http port and https port can be same with bind_port
vhost_http_port = 80
vhost_https_port = 443
# set dashboard_addr and dashboard_port to view dashboard of frps
# dashboard_addr's default value is same with bind_addr
# dashboard is available only if dashboard_port is set
dashboard_addr = 0.0.0.0
dashboard_port = 5445
# dashboard user and passwd for basic auth protect, if not set, both default value is admin
dashboard_user = ${set_dashboard_user}
dashboard_pwd = ${set_dashboard_pwd}
# dashboard assets directory(only for debug mode)
# assets_dir = ./static
# console or real logFile path like ./frps.log
log_file = ${FRPS_LOG}
# trace, debug, info, warn, error
log_level = ${set_log_level}
log_max_days = ${set_log_max_days}
# auth token
token = ${set_token}
# heartbeat configure, it's not recommended to modify the default value
# the default value of heartbeat_timeout is 90
# heartbeat_timeout = 90
# only allow frpc to bind ports you list, if you set nothing, there won't be any limit
#allow_ports = 2000-3000,3001,3003,4000-50000
# pool_count in each proxy will change to max_pool_count if they exceed the maximum value
max_pool_count = ${set_max_pool_count}
# max ports can be used for each client, default value is 0 means no limit
max_ports_per_client = ${set_max_ports_per_client}
# authentication_timeout means the timeout interval (seconds) when the frpc connects frps
# if authentication_timeout is zero, the time is not verified, default is 900s
authentication_timeout = ${set_authentication_timeout}
# if subdomain_host is not empty, you can set subdomain when type is http or https in frpc's configure file
# when subdomain is test, the host used by routing is test.frps.com
subdomain_host = ${set_subdomain_host}
# if tcp stream multiplexing is used, default is true
tcp_mux = ${set_tcp_mux}

EOF

echo "+---------------------------------------------+"
echo "|              Frps On Docker                 |"
echo "+---------------------------------------------+"
echo "|       Images:{frps-docker:latest}           |"
echo "+---------------------------------------------+"
echo "|     Intro: https://github.com/clangcn       |"
echo "+---------------------------------------------+"
echo " dashboard_user = ${set_dashboard_user}"
echo " dashboard_pwd = ${set_dashboard_pwd}"
echo " token = ${set_token}"
echo " subdomain_host = ${set_subdomain_host}"
echo " max_pool_count = ${set_max_pool_count}"
echo " max_ports_per_client = ${set_max_ports_per_client}"
echo " authentication_timeout = ${set_authentication_timeout}"
echo " log_level = ${set_log_level}"
echo " log_max_days = ${set_log_max_days}"
echo " tcp_mux = ${set_tcp_mux}"
echo "+---------------------------------------------+"
rm -f ${FRPS_LOG} > /dev/null 2>&1
echo "Starting frps $(${FRPS_BIN} -v) ..."
${FRPS_BIN} -c ${FRPS_CONF} &
sleep 0.3
netstat -ntlup | grep "frps"
exec "tail" -f ${FRPS_LOG}
