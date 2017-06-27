#!/bin/bash
#########################################################################
# File Name: frpc.sh
# Version:1.1.20170627
# Created Time: 2017-06-27
#########################################################################

set -e
FRPC_BIN="/usr/local/frpc/frpc"
FRPC_CONF="/usr/local/frpc/frpc.ini"
FRPC_LOG="/var/log/frpc.log"

str_log_level=${str_log_level:-info}   # set log level: debug, info, warn, error

echo "+---------------------------------------------+"
echo "|              Frpc On Docker                 |"
echo "+---------------------------------------------+"
echo "|       Images:{frpc-docker:latest}           |"
echo "+---------------------------------------------+"
echo "|     Intro: https://github.com/clangcn       |"
echo "+---------------------------------------------+"
echo ""
if [ ! -r ${FRPC_CONF} ]; then
    echo "config file ${FRPC_CONF} not found"
    exit 1
fi
touch ${FRPC_LOG} > /dev/null 2>&1
. ./start_frpc.sh
tail -f ${FRPC_LOG}
exec "tail" -f ${FRPC_LOG}
