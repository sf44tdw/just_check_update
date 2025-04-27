#!/bin/bash

#使用するコマンド
export EX_CHECK_UPDATE_COMMAND="dnf"
export EX_CHECK_UPDATE_COMMAND_LINE="${EX_CHECK_UPDATE_COMMAND} clean all && ${EX_CHECK_UPDATE_COMMAND} update --assumeno"

readonly SCRIPT_DIR=$(cd $(dirname $0); pwd)
readonly BACKEND_PATH="${SCRIPT_DIR}/check_update_backend"
eval "${BACKEND_PATH}"
