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
. $UTIL/bin/loadutilconf.sh
. $UTIL/bin/logging.sh
. $UTIL/bin/sendmail.sh
. $UTIL/bin/usage.sh
. $UTIL/bin/devel.sh

DYNDNS_TOOL=dyndns
DYNDNS_VERSION=ver.1.0
DYNDNS_HOME=$UTIL_ROOT/$DYNDNS_TOOL/$DYNDNS_VERSION
DYNDNS_CFG=$DYNDNS_HOME/conf/$DYNDNS_TOOL.cfg
DYNDNS_UTIL_CFG=$DYNDNS_HOME/conf/${DYNDNS_TOOL}_util.cfg
DYNDNS_LOG=$DYNDNS_HOME/log

declare -A DYNDNS_USAGE=(
    [TOOL_NAME]="__$DYNDNS_TOOL"
    [EX-PRE]="# Start dynamic dns client"
    [EX]="__$DYNDNS_TOOL"
)

declare -A LOG=(
    [NAME]="$DYNDNS_TOOL"
    [FLAG]="info"
    [PATH]="$DYNDNS_LOG"
    [MSG]="Started $DYNDNS_TOOL"
)

TOOL_DBG="false"

#
# @brief   Main function 
# @param   Value optional help
# @exitval Function __dyndns exit with integer value
#			0   - tool finished with success operation 
#			128 - failed to load tool script configuration from file
#			129 - failed to load tool script utilities configuration from file
#			130 - process is already running
#			131 - missing external tool ssclient
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __dyndns "$HELP"
#
function __dyndns() {
	local HELP=$1
	if [ "$HELP" == "help" ]; then
		__usage $DYNDNS_USAGE
		exit 0
	fi
	local FUNC=${FUNCNAME[0]}
	local MSG=""
	if [ "$TOOL_DBG" == "true" ]; then
		MSG="Starting dynamic dns client"
		printf "$DSTA" "$DYNDNS_TOOL" "$FUNC" "$MSG"
	fi
	declare -A configdyndns=()
	__loadconf $DYNDNS_CFG configdyndns
	local STATUS=$?
	if [ "$STATUS" -eq "$NOT_SUCCESS" ]; then
		MSG="Failed to load tool script configuration"
		if [ "$TOOL_DBG" == "true" ]; then
			printf "$DSTA" "$DYNDNS_TOOL" "$FUNC" "$MSG"
		else
			printf "$SEND" "[$DYNDNS_TOOL]" "$MSG"
		fi
		exit 128
	fi
	declare -A cfgdydns=()
	__loadutilconf $DYNDNS_UTIL_CFG cfgdydns
	STATUS=$?
	if [ "$STATUS" -eq "$SUCCESS" ]; then
		__checktool "${cfgdydns[DDCLIENT_PATH]}"
		STATUS=$?
		if [ "$STATUS" -eq "$SUCCESS" ]; then
			__checkprocess "${cfgdydns[DDCLIENT_PATH]}"
			STATUS=$?
			if [ "$STATUS" -eq "$NOT_SUCCESS" ]; then
				eval "${cfgdydns[DDCLIENT_PATH]} ${cfgdydns[DDCLIENT_ARGS]}"
				if [ "$TOOL_DBG" == "true" ]; then
					printf "$DEND" "$DYNDNS_TOOL" "$FUNC" "Done"
				fi
				exit 0
			fi
			exit 130
		fi
		MSG="Missing external tool ${cfgdydns[DDCLIENT_PATH]}"
		if [ "${configdyndns[LOGGING]}" == "true" ]; then
			LOG[MSG]=$MSG
			LOG[FLAG]="error"
			__logging $LOG
		fi
		if [ "${configdyndns[EMAILING]}" == "true" ]; then
			__sendmail "$MSG" "${configdyndns[ADMIN_EMAIL]}"
		fi
		exit 131
    fi
    MSG="Failed to load tool script utilities configuration"
	if [ "$TOOL_DBG" == "true" ]; then
		printf "$DSTA" "$DYNDNS_TOOL" "$FUNC" "$MSG"
	else
		printf "$SEND" "[$DYNDNS_TOOL]" "$MSG"
	fi
    exit 129
}


#
# @brief   Main entry point
# @param   Value optional help
# @exitval Script tool atmanger exit with integer value
#			0   - tool finished with success operation 
# 			127 - run tool script as root user from cli
#			128 - failed to load tool script configuration from file
#			129 - failed to load tool script utilities configuration from file
#			130 - process is already running
#			131 - missing external tool ssclient
#
printf "\n%s\n%s\n\n" "$DYNDNS_TOOL $DYNDNS_VERSION" "`date`"
__checkroot
STATUS=$?
if [ "$STATUS" -eq "$SUCCESS" ]; then
	set -u
	HELP=${1:-}
	__dyndns "$HELP"
fi

exit 127

