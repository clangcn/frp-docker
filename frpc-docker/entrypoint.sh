#!/bin/bash
#########################################################################
# File Name: frpc.sh
# Version:1.2.20180602
# Created Time: 2018-06-02
#########################################################################
__readINI() {
 INIFILE=$1; SECTION=$2; ITEM=$3
 _readIni=`awk -F '=' '/\['$SECTION'\]/{a=1}a==1&&$1~/'$ITEM'/{print $2;exit}' $INIFILE`
echo ${_readIni}
}

set -e
FRPC_BIN="/usr/local/frpc/frpc"
FRPC_CONF="/usr/local/frpc/frpc.ini"
FRPC_LOG=$(__readINI ${FRPC_CONF} common log_file)
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
[ -z ${FRPC_LOG} ] && echo "Log file not setting,exit!" && exit 1
touch ${FRPC_LOG} > /dev/null 2>&1
echo "Starting frpc $(${FRPC_BIN} -v) ..."
${FRPC_BIN} -c ${FRPC_CONF} &
exec "tail" -f ${FRPC_LOG}
