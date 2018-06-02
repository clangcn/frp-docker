#!/bin/bash
#########################################################################
# File Name: frps.sh
# Version:1.2.20180602
# Created Time: 2018-06-02
#########################################################################

set -e
FRPS_BIN="/usr/local/frps/frps"
FRPS_CONF="/usr/local/frps/frps.ini"
FRPS_LOG="/var/log/frps.log"
# ======= FRPS CONFIG ======
set_dashboard_user=${set_dashboard_user:-admin}              #dashboard_user = admin
set_dashboard_pwd=${set_dashboard_pwd:-admin}                #dashboard_pwd = admin
set_token=${set_token:-password}                             #token = password
set_subdomain_host=${set_subdomain_host:-}                   #subdomain_host =
set_tcp_mux=${set_tcp_mux:-true}                             #tcp_mux = true
set_max_pool_count=${set_max_pool_count:-50}                 #max_pool_count = 50
str_log_level=${str_log_level:-info}                         #log_level = info
set_log_max_days=${set_log_max_days:-3}                      #log_max_days = 3

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
# set dashboard_addr and dashboard_port to view dashboard of frps
# dashboard_addr's default value is same with bind_addr
# dashboard is available only if dashboard_port is set
dashboard_addr = 0.0.0.0
dashboard_port = 5445
# dashboard user and pwd for basic auth protect, if not set, both default value is admin
dashboard_user = ${set_dashboard_user}
dashboard_pwd = ${set_dashboard_pwd}

vhost_http_port = 80
vhost_https_port = 443
# console or real logFile path like ./frps.log
log_file = ${FRPS_LOG}
# debug, info, warn, error
log_level = ${str_log_level}
log_max_days = ${set_log_max_days}
# if you enable privilege mode, frpc can create a proxy without pre-configure in frps when privilege_token is correct
token = ${set_token}

# if subdomain_host is not empty, you can set subdomain when type is http or https in frpc's configure file
# when subdomain is test, the host used by routing is test.frps.com
subdomain_host = ${set_subdomain_host}

# pool_count in each proxy will change to max_pool_count if they exceed the maximum value
max_pool_count = ${set_max_pool_count}
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
echo ""
rm -f ${FRPS_LOG} > /dev/null 2>&1
echo "subdomain_host = ${set_subdomain_host}"
echo "Starting frps $(${FRPS_BIN} -v) ..."
${FRPS_BIN} -c ${FRPS_CONF} &
sleep 0.3
netstat -ntlup | grep "frps"
exec "tail" -f ${FRPS_LOG}
