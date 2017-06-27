#!/bin/bash
#########################################################################
# File Name: frpc.sh
# Version:1.1.20170627
# Created Time: 2017-06-27
#########################################################################
echo "Starting frpc $(${FRPC_BIN} -v) ..."
echo "${FRPC_BIN} -c ${FRPC_CONF} -L ${FRPC_LOG} --log-level=${str_log_level}"
${FRPC_BIN} -c ${FRPC_CONF} -L ${FRPC_LOG} --log-level=${str_log_level} &
