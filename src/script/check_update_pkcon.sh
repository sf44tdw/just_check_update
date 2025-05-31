#!/bin/bash

#使用するコマンド
export EX_CHECK_UPDATE_COMMAND="pkcon"
export EX_CHECK_UPDATE_COMMAND_LINE="${EX_CHECK_UPDATE_COMMAND} refresh force && ${EX_CHECK_UPDATE_COMMAND} get-updates"

readonly SCRIPT_DIR=$(cd $(dirname $0); pwd)
readonly BACKEND_PATH="${SCRIPT_DIR}/check_update_backend"
eval "${BACKEND_PATH}"

