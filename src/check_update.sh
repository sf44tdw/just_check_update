#!/bin/bash

readonly ROOT_HOME='/root'
readonly ROOT_BASH_PROFILE_PATH="${ROOT_HOME}/.bash_profile"
readonly ROOT_PROFILE_PATH="${ROOT_HOME}/.profile"

if [ -f "${ROOT_BASH_PROFILE_PATH}" ]; then
	source "${ROOT_BASH_PROFILE_PATH}" >/dev/null 2>&1 || exit 200
elif [ -f "${ROOT_PROFILE_PATH}" ]; then
	source "${ROOT_PROFILE_PATH}" >/dev/null 2>&1 || exit 210
else
	exit 220
fi

#使用するコマンド
readonly UPDATE_COMMAND="dnf"
readonly UPDATE_COMMAND_LINE="${UPDATE_COMMAND} update --assumeno"

#このスクリプトの名前。
readonly MY_NAME=$(basename "${0}")

#ロックファイルのパス
readonly _lockfile="/tmp/${MY_NAME}.lock"

function is_numeric() {
	local -r INPUT_VALUE="${1}"
	expr "${INPUT_VALUE}" + 1 >/dev/null 2>&1
	local -r ret="${?}"
	if [ "${ret}" -ge 2 ]; then
		return "${ret}"
	fi
	return 0
}

function delete_lock_file_and_exit() {
	local -r EXIT_CODE="${1}"
	is_numeric "${EXIT_CODE}"
	local -r ret="${?}"
	if [ "${ret}" -ge 2 ]; then
		echo "指定された戻り値が数字ではない。戻り値=${EXIT_CODE}"1 >&2
		exit 100
	fi
	if [ -h "${_lockfile}" ]; then
		if ! rm -f "${_lockfile}" >/dev/null 2>&1; then
			echo "ロックファイル削除失敗。戻り値はrmのものになる。ロックファイル=${_lockfile}"1 >&2
			exit "${?}"
		fi
	fi
	exit "${EXIT_CODE}"
}

function delete_lock_and_exit() {
	local -r YMD_VAL=$(date +%Y%m%d%H%M%S)
	echo "${YMD_VAL}_${1}_${3}" >>"${2}"
	delete_lock_file_and_exit "${3}"
}

function wait_5_min() {
	sleep 300
}

readonly LOGDIR="/var/log/update-check-log"
readonly LOGFILE="${LOGDIR}/$(date +%Y%m%d%H%M%S).log"
mkdir -p "${LOGDIR}" && chmod 755 "${LOGDIR}" || exit 1

wait_5_min

echo "$(date +%Y%m%d%H%M%S)_開始します。" >>"${LOGFILE}"

#ロックファイル生成。
echo "$(date +%Y%m%d%H%M%S)_ロックファイル生成。" >>"${LOGFILE}"
ln -s /dummy "${_lockfile}" >/dev/null 2>&1 || {
	echo "$(date +%Y%m%d%H%M%S)_Cannot run multiple instance." >>"${LOGFILE}"
	#他のプロセスが起動中なのでロックファイルは削除しない。
	exit 110
}

trap 'rm "${_lockfile}"; exit' SIGHUP SIGINT SIGQUIT SIGTERM

# ファイル更新日時が5000日を越えたログファイルを削除
echo "$(date +%Y%m%d%H%M%S)_旧ログ削除。" >>"${LOGFILE}"
readonly PARAM_DATE_NUM=5000
find "${LOGDIR}" -name "*.log" -type f -mtime +"${PARAM_DATE_NUM}" -exec rm -f {} \;

readonly UPDATE_PROC_LIST=$(pgrep -l "${UPDATE_COMMAND}" | grep -v grep | grep -v "${MY_NAME}")
readonly UPDATE_PROC_COUNT=$(echo "${UPDATE_PROC_LIST}" | grep -v '^\s*$' | wc -l)
if [ "${UPDATE_PROC_COUNT}" != 0 ]; then
	delete_lock_and_exit "${UPDATE_COMMAND_LINE}が起動中です。終了します。" "${LOGFILE}" 2
fi

echo "$(date +%Y%m%d%H%M%S)_チェック開始。" >>"${LOGFILE}"

eval "${UPDATE_COMMAND_LINE} >> ${LOGFILE} 2>&1"

readonly RET_COMMAND="${?}"
if [ "${RET_COMMAND}" -ne 0 ]; then
	echo "$(date +%Y%m%d%H%M%S)_${UPDATE_COMMAND_LINE}の戻り値が${RET_PKCON}です。" >>"${LOGFILE}"
fi

echo "$(date +%Y%m%d%H%M%S)_チェック終了。" >>"${LOGFILE}"

delete_lock_and_exit "正常終了します。" "${LOGFILE}" 0
