#!/bin/bash

#使用するコマンド
export EX_CHECK_UPDATE_COMMAND="pkcon"
export EX_CHECK_UPDATE_COMMAND_LINE="${CHECK_UPDATE_COMMAND} refresh && ${CHECK_UPDATE_COMMAND} get-updates"

check_update_backend.sh
