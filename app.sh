#!/bin/bash

# init
set -euo pipefail # エラー発生時は即座に終了
# set -x # 実行コマンドをデバッグ用に表示
cd "$(dirname "$0")" # 作業ディレクトリを移動作業ディレクトリを移動
SCRIPT_NAME="$(basename "${0}")" # ログ出力時に使用するスクリプト名
echo "${SCRIPT_NAME}: start"

# lib
debug_log() {
  if [ "${DEBUG:-false}" = "true" ]; then
    echo "${SCRIPT_NAME}<debug>: ${1}"
  fi
}
check_command_available() {
  for cmd in "$@"; do
    command -v "${cmd}" >/dev/null 2>&1 || { echo "${SCRIPT_NAME}: ${cmd} is required"; exit 1; } # 必要なコマンドがなければ終了
  done
}

# init2
# check_command_available "jq" "curl" # 必要なコマンドがあるかどうかあらかじめ確認
debug_log "start" # デバッグモードがオンになっているかどうかがここでわかる

# constant
ROOT_DIR_PATH="${PWD}/" # サブディレクトリならばここを/../に変える
DATA_DIR_PATH="${ROOT_DIR_PATH}data/"
mkdir -p "${DATA_DIR_PATH}" # ディレクトリはここで作成しておく

# output
OUTPUT_FILE_PATH="$(realpath "${1:-"${DATA_DIR_PATH}output.txt"}")"

# input
INPUT_TEXT="${2:-"hello world"}"

# tmp
TMP_DIR_PATH="$(mktemp -p "${DATA_DIR_PATH}" -d)/"
echo "${SCRIPT_NAME}: TMP_DIR_PATH: ${TMP_DIR_PATH}"

cleanup() {
  echo "${SCRIPT_NAME}: Cleaning up temporary files..."
  rm -rf "$TMP_DIR_PATH"
}

# スクリプト終了時・異常終了時に cleanup を実行
trap cleanup EXIT INT TERM

# main
echo "${SCRIPT_NAME}: output ${OUTPUT_FILE_PATH}"
echo "${SCRIPT_NAME}: input ${INPUT_TEXT}"
debug_log "${INPUT_TEXT} is great."

echo "${INPUT_TEXT} from ${SCRIPT_NAME}" >> "$OUTPUT_FILE_PATH"
date >> "$OUTPUT_FILE_PATH"

# call core module
./core/func1.sh "$OUTPUT_FILE_PATH" "$INPUT_TEXT" # 引数はダブルクオートで囲う
./core/func1.sh

exit 0


