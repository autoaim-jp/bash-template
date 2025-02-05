#!/bin/bash

# init
# set -euxo pipefail
set -euo pipefail
cd "$(dirname "$0")"
SCRIPT_NAME="$(basename "${0}")"
# command -v curl >/dev/null 2>&1 || { echo "${SCRIPT_NAME}: curl is required"; exit 1; }
echo "${SCRIPT_NAME}: start"

# lib
debug_log() {
  if [ "${DEBUG:-false}" = "true" ]; then
    echo "${SCRIPT_NAME}<debug>: ${1}"
  fi
}

# constant
ROOT_DIR_PATH=${PWD}/../ # サブディレクトリなのでここを変更
DATA_DIR_PATH="${ROOT_DIR_PATH}data/"
mkdir -p "${DATA_DIR_PATH}"

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

echo "${INPUT_TEXT}" >> "$OUTPUT_FILE_PATH"
date >> "$OUTPUT_FILE_PATH"

exit 0


