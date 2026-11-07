#!/bin/bash

#使用するコマンド
export EX_CHECK_UPDATE_COMMAND="pkcon"
export EX_CHECK_UPDATE_COMMAND_REFRESH="${EX_CHECK_UPDATE_COMMAND} refresh"
export EX_CHECK_UPDATE_COMMAND_UPDATE="${EX_CHECK_UPDATE_COMMAND} -d update -y --noninteractive"

readonly SCRIPT_DIR=$(cd "$(dirname "${0}")" && pwd)
readonly BACKEND_PATH="${SCRIPT_DIR}/check_update_backend"
bash "${BACKEND_PATH}"

