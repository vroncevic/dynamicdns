#!/bin/bash
#
# @brief   Start Dynamic DNS Client
# @version ver.1.0
# @date    Mon Jun 02 13:36:32 2015
# @company Frobas IT Department, www.frobas.com 2015
# @author  Vladimir Roncevic <vladimir.roncevic@frobas.com>
#
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=${UTIL_ROOT}/sh_util/${UTIL_VERSION}
UTIL_LOG=${UTIL}/log

.	${UTIL}/bin/devel.sh
.	${UTIL}/bin/usage.sh
.	${UTIL}/bin/check_root.sh
.	${UTIL}/bin/check_tool.sh
.	${UTIL}/bin/logging.sh
.	${UTIL}/bin/load_conf.sh
.	${UTIL}/bin/load_util_conf.sh
.	${UTIL}/bin/progress_bar.sh
.	${UTIL}/bin/check_process.sh

DYNDNS_TOOL=dyndns
DYNDNS_VERSION=ver.1.0
DYNDNS_HOME=${UTIL_ROOT}/${DYNDNS_TOOL}/${DYNDNS_VERSION}
DYNDNS_CFG=${DYNDNS_HOME}/conf/${DYNDNS_TOOL}.cfg
DYNDNS_UTIL_CFG=${DYNDNS_HOME}/conf/${DYNDNS_TOOL}_util.cfg
DYNDNS_LOG=${DYNDNS_HOME}/log

declare -A DYNDNS_USAGE=(
	[USAGE_TOOL]="__${DYNDNS_TOOL}"
	[USAGE_EX_PRE]="# Start dynamic dns client"
	[USAGE_EX]="__${DYNDNS_TOOL}"
)

declare -A DYNDNS_LOGGING=(
	[LOG_NAME]="${DYNDNS_TOOL}"
	[LOG_FLAG]="info"
	[LOG_PATH]="${DYNDNS_LOG}"
	[LOG_MSGE]="Started ${DYNDNS_TOOL}"
)

declare -A PB_STRUCTURE=(
	[BW]=50
	[MP]=100
	[SLEEP]=0.01
)

TOOL_DBG="false"
TOOL_LOG="false"
TOOL_NOTIFY="false"

#
# @brief   Main function
# @param   Value optional help
# @exitval Function __dyndns exit with integer value
#			0   - tool finished with success operation
#			128 - failed to load tool script configuration from files
#			129 - missing external tool ddclient
#			130 - process is already running
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __dyndns "$HELP"
#
function __dyndns() {
	local HELP=$1
	if [ "${HELP}" == "help" ]; then
		__usage DYNDNS_USAGE
		exit 0
	fi
	local FUNC=${FUNCNAME[0]} MSG="None" STATUS_CONF STATUS_CONF_UTIL STATUS
	MSG="Loading basic and util configuration!"
	__info_debug_message "$MSG" "$FUNC" "$DYNDNS_TOOL"
	__progress_bar PB_STRUCTURE
	declare -A config_dyndns=()
	__load_conf "$DYNDNS_CFG" config_dyndns
	STATUS_CONF=$?
	declare -A config_dyndns_util=()
	__load_util_conf "$DYNDNS_UTIL_CFG" config_dyndns_util
	STATUS_CONF_UTIL=$?
	declare -A STATUS_STRUCTURE=(
		[1]=$STATUS_CONF [2]=$STATUS_CONF_UTIL
	)
	__check_status STATUS_STRUCTURE
	STATUS=$?
	if [ $STATUS -eq $NOT_SUCCESS ]; then
		MSG="Force exit!"
		__info_debug_message_end "$MSG" "$FUNC" "$DYNDNS_TOOL"
		exit 128
	fi
	TOOL_LOG=${config_dyndns[LOGGING]}
	TOOL_DBG=${config_dyndns[DEBUGGING]}
	TOOL_NOTIFY=${config_dyndns[EMAILING]}
	local DDC=${config_dyndns_util[DDCLIENT_PATH]}
	__check_tool "${DDC}"
	STATUS=$?
	if [ $STATUS -eq $SUCCESS ]; then
		__check_process "${DDC}"
		STATUS=$?
		if [ $STATUS -eq $NOT_SUCCESS ]; then
			eval "${DDC} ${config_dyndns_util[DDCLIENT_ARGS]}"
			__info_debug_message_end "Done" "$FUNC" "$DYNDNS_TOOL"
			exit 0
		fi
		MSG="Force exit!"
		__info_debug_message_end "$MSG" "$FUNC" "$DYNDNS_TOOL"
		exit 130
	fi
	MSG="Missing tool ${DDC}"
	DYNDNS_LOGGING[LOG_MSGE]=$MSG
	DYNDNS_LOGGING[LOG_FLAG]="error"
	__logging DYNDNS_LOGGING
	__sendmail "$MSG" "${configdyndns[ADMIN_EMAIL]}"
	MSG="Force exit!"
	__info_debug_message_end "$MSG" "$FUNC" "$DYNDNS_TOOL"
	exit 129
}


#
# @brief   Main entry point
# @param   Value optional help
# @exitval Script tool atmanger exit with integer value
#			0   - tool finished with success operation
#			127 - run tool script as root user from cli
#			128 - failed to load tool script configuration from files
#			129 - missing external tool ddclient
#			130 - process is already running
#
printf "\n%s\n%s\n\n" "${DYNDNS_TOOL} ${DYNDNS_VERSION}" "`date`"
__check_root
STATUS=$?
if [ $STATUS -eq $SUCCESS ]; then
	__dyndns $1
fi

exit 127

