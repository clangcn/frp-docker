#!/bin/bash
#########################################################################
# File Name: frps.sh
# Version:1.1.20170627
# Created Time: 2017-06-27
#########################################################################

set -e
FRPS_BIN="/usr/local/frps/frps"
FRPS_CONF="/usr/local/frps/frps.ini"
FRPS_LOG="/var/log/frps.log"
# ======= FRPS CONFIG ======
set_bind_port=${set_bind_port:-5443}                         #bind_port = 5443
set_kcp_bind_port=${set_bind_port}                           #kcp_bind_port = bind_port
set_vhost_http_port=${set_vhost_http_port:-80}               #vhost_http_port = 80
set_vhost_https_port=${set_vhost_https_port:-443}            #vhost_https_port = 443
set_dashboard_port=${set_dashboard_port:-6443}               #dashboard_port = 6443
set_dashboard_user=${set_dashboard_user:-admin}              #dashboard_user = admin
set_dashboard_pwd=${set_dashboard_pwd:-admin}                #dashboard_pwd = admin
set_privilege_token=${set_privilege_token:-password}         #privilege_token = password
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
bind_port = ${set_bind_port}
# udp port used for kcp protocol, it can be same with 'bind_port'
# if not set, kcp is disabled in frps
kcp_bind_port = ${set_bind_port}
# if you want to configure or reload frps by dashboard, dashboard_port must be set
dashboard_port = ${set_dashboard_port}
# dashboard user and pwd for basic auth protect, if not set, both default value is admin
dashboard_user = ${set_dashboard_user}
dashboard_pwd = ${set_dashboard_pwd}

vhost_http_port = ${set_vhost_http_port}
vhost_https_port = ${set_vhost_https_port}
# console or real logFile path like ./frps.log
log_file = ${FRPS_LOG}
# debug, info, warn, error
log_level = ${str_log_level}
log_max_days = ${set_log_max_days}
# if you enable privilege mode, frpc can create a proxy without pre-configure in frps when privilege_token is correct
privilege_token = ${set_privilege_token}
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
echo "Starting frps $(${FRPS_BIN} -v) ..."
${FRPS_BIN} -c ${FRPS_CONF} &
sleep 0.3
netstat -ntlup | grep "frps"
exec "tail" -f ${FRPS_LOG}
