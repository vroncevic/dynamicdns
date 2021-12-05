#!/bin/bash
#
# @brief   Start Dynamic DNS Client
# @version ver.2.0
# @date    Mon 22 Nov 2021 12:24:35 AM CET
# @company None, free software to use 2021
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=${UTIL_ROOT}/sh_util/${UTIL_VERSION}
UTIL_LOG=${UTIL}/log

.    ${UTIL}/bin/devel.sh
.    ${UTIL}/bin/usage.sh
.    ${UTIL}/bin/check_root.sh
.    ${UTIL}/bin/check_tool.sh
.    ${UTIL}/bin/logging.sh
.    ${UTIL}/bin/load_conf.sh
.    ${UTIL}/bin/load_util_conf.sh
.    ${UTIL}/bin/progress_bar.sh
.    ${UTIL}/bin/check_process.sh

DYNAMICDNS_TOOL=dynamicdns
DYNAMICDNS_VERSION=ver.2.0
DYNAMICDNS_HOME=${UTIL_ROOT}/${DYNAMICDNS_TOOL}/${DYNAMICDNS_VERSION}
DYNAMICDNS_CFG=${DYNAMICDNS_HOME}/conf/${DYNAMICDNS_TOOL}.cfg
DYNAMICDNS_UTIL_CFG=${DYNAMICDNS_HOME}/conf/${DYNAMICDNS_TOOL}_util.cfg
DYNAMICDNS_LOGO=${DYNAMICDNS_HOME}/conf/${DYNAMICDNS_TOOL}.logo
DYNAMICDNS_LOG=${DYNAMICDNS_HOME}/log

tabs 4
CONSOLE_WIDTH=$(stty size | awk '{print $2}')

.    ${DYNAMICDNS_HOME}/bin/center.sh
.    ${DYNAMICDNS_HOME}/bin/display_logo.sh

declare -A DYNAMICDNS_USAGE=(
    [USAGE_TOOL]="${DYNAMICDNS_TOOL}"
    [USAGE_EX_PRE]="# Start dynamic dns client"
    [USAGE_EX]="${DYNAMICDNS_TOOL}"
)

declare -A DYNAMICDNS_LOGGING=(
    [LOG_NAME]="${DYNAMICDNS_TOOL}"
    [LOG_FLAG]="info"
    [LOG_PATH]="${DYNAMICDNS_LOG}"
    [LOG_MSGE]="Started ${DYNAMICDNS_TOOL}"
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
#            0   - tool finished with success operation
#            128 - failed to load tool script configuration from files
#            129 - missing external tool ddclient
#            130 - process is already running
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __dyndns "help"
#
function __dyndns {
    local HELP=$1
    display_logo
    if [ "${HELP}" == "help" ]; then
        usage DYNAMICDNS_USAGE
        exit 0
    fi
    local FUNC=${FUNCNAME[0]} MSG="None" STATUS_CONF STATUS_CONF_UTIL STATUS
    MSG="Loading basic and util configuration!"
    info_debug_message "$MSG" "$FUNC" "$DYNAMICDNS_TOOL"
    progress_bar PB_STRUCTURE
    declare -A config_dyndns=()
    load_conf "$DYNAMICDNS_CFG" config_dyndns
    STATUS_CONF=$?
    declare -A config_dyndns_util=()
    load_util_conf "$DYNAMICDNS_UTIL_CFG" config_dyndns_util
    STATUS_CONF_UTIL=$?
    declare -A STATUS_STRUCTURE=(
        [1]=$STATUS_CONF [2]=$STATUS_CONF_UTIL
    )
    check_status STATUS_STRUCTURE
    STATUS=$?
    if [ $STATUS -eq $NOT_SUCCESS ]; then
        MSG="Force exit!"
        info_debug_message_end "$MSG" "$FUNC" "$DYNAMICDNS_TOOL"
        exit 128
    fi
    TOOL_LOG=${config_dyndns[LOGGING]}
    TOOL_DBG=${config_dyndns[DEBUGGING]}
    TOOL_NOTIFY=${config_dyndns[EMAILING]}
    local DDC=${config_dyndns_util[DDCLIENT_PATH]}
    check_tool "${DDC}"
    STATUS=$?
    if [ $STATUS -eq $SUCCESS ]; then
        check_process "${DDC}"
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            eval "${DDC} ${config_dyndns_util[DDCLIENT_ARGS]}"
            info_debug_message_end "Done" "$FUNC" "$DYNAMICDNS_TOOL"
            exit 0
        fi
        MSG="Force exit!"
        info_debug_message_end "$MSG" "$FUNC" "$DYNAMICDNS_TOOL"
        exit 130
    fi
    MSG="Missing tool ${DDC}"
    DYNAMICDNS_LOGGING[LOG_MSGE]=$MSG
    DYNAMICDNS_LOGGING[LOG_FLAG]="error"
    logging DYNAMICDNS_LOGGING
    sendmail "$MSG" "${config_dyndns[ADMIN_EMAIL]}"
    MSG="Force exit!"
    info_debug_message_end "$MSG" "$FUNC" "$DYNAMICDNS_TOOL"
    exit 129
}


#
# @brief   Main entry point
# @param   Value optional help
# @exitval Script tool atmanger exit with integer value
#            0   - tool finished with success operation
#            127 - run tool script as root user from cli
#            128 - failed to load tool script configuration from files
#            129 - missing external tool ddclient
#            130 - process is already running
#
printf "\n%s\n%s\n\n" "${DYNAMICDNS_TOOL} ${DYNAMICDNS_VERSION}" "`date`"
check_root
STATUS=$?
if [ $STATUS -eq $SUCCESS ]; then
    __dyndns $1
fi

exit 127
