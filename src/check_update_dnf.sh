#!/bin/bash

#使用するコマンド
export EX_CHECK_UPDATE_COMMAND="dnf"
export EX_CHECK_UPDATE_COMMAND_LINE="${EX_CHECK_UPDATE_COMMAND} clean all && ${EX_CHECK_UPDATE_COMMAND} update --assumeno"

readonly BACKEND_PATH="`pwd`/check_update_backend.sh"
eval "${BACKEND_PATH}"
