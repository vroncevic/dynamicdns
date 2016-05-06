#!/bin/bash
#
# @brief   Start dynamic dns client
# @version ver.1.0
# @date    Mon Jun 02 13:36:32 2015
# @company Frobas IT Department, www.frobas.com 2015
# @author  Vladimir Roncevic <vladimir.roncevic@frobas.com>
#
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=$UTIL_ROOT/sh-util-srv/$UTIL_VERSION
UTIL_LOG=$UTIL/log

. $UTIL/bin/checkroot.sh
. $UTIL/bin/checktool.sh
. $UTIL/bin/checkprocess.sh
. $UTIL/bin/logging.sh
. $UTIL/bin/usage.sh
. $UTIL/bin/devel.sh

TOOL_NAME=dyndns
TOOL_VERSION=ver.1.0
TOOL_HOME=$UTIL_ROOT/$TOOL_NAME/$TOOL_VERSION
TOOL_CFG=$TOOL_HOME/conf/$TOOL_NAME.cfg
TOOL_LOG=$TOOL_HOME/log

declare -A DYNDNS_USAGE=(
    [TOOL_NAME]="__$TOOL_NAME"
    [EX-PRE]="# Start dynamic dns client"
    [EX]="__$TOOL_NAME"	
)

declare -A LOG=(
    [NAME]="$TOOL_NAME"
    [FLAG]="info"
    [PATH]="$TOOL_LOG"
    [MSG]="Started $TOOL_NAME"
)

TOOL_DEBUG="false"

DDCLIENT_PATH="/usr/sbin/ddclient"
DDCLIENT_ARGS=" -daemon=0 -verbose -noquiet"

#
# @brief Main function 
# @param Value optional help
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __dyndns "$HELP"
#
function __dyndns() {
	HELP=$1
	if [ -n "$HELP" ]; then
		__usage $DYNDNS_USAGE
		exit 0
	fi
    __checktool $DDCLIENT_PATH
    STATUS=$?
    if [ "$STATUS" -eq "$SUCCESS" ]; then
        __checkprocess "$DDCLIENT_PATH"
        STATUS=$?
        if [ "$STATUS" -eq "$NOT_SUCCESS" ]; then
            eval "$DDCLIENT_PATH$DDCLIENT_ARGS"
        fi
		exit 0
    fi
	LOG[FLAG]="error"
	LOG[MSG]="Check tool $DDCLIENT_PATH"
	__logging $LOG
    exit 128
}


#
# @brief   Main entry point
# @param   Value optional help
# @exitval Script tool atmanger exit with integer value
#			0   - success operation 
# 			127 - run as root user
#			128 - missing ddclient tool
#
printf "\n%s\n%s\n\n" "$TOOL_NAME $TOOL_VERSION" "`date`"
__checkroot
STATUS=$?
if [ "$STATUS" -eq "$SUCCESS" ]; then
	__dyndns "$1"
fi

exit 127

