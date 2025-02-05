#!/bin/bash

# init
# set -euxo pipefail # エラー発生時は即座に終了 実行コマンドをデバッグ用に表示
set -euo pipefail # エラー発生時は即座に終了
cd "$(dirname "$0")" # 作業ディレクトリを移動作業ディレクトリを移動
SCRIPT_NAME=$(basename ${0}) # ログ出力時に使用するスクリプト名
# command -v curl >/dev/null 2>&1 || { echo "${SCRIPT_NAME}: curl is required"; exit 1; } # 必要なコマンドがなければ終了
echo "${SCRIPT_NAME}: start"

# constant
ROOT_DIR_PATH=${PWD}/ # サブディレクトリならばここを/../に変える
DATA_DIR_PATH=${ROOT_DIR_PATH}data/
mkdir -p ${DATA_DIR_PATH} # ディレクトリはここで作成しておく

# output
OUTPUT_FILE_PATH="${1:-"output.txt"}"

# input
INPUT_FILE_PATH="${2:-"input.txt"}"

# tmp
TMP_DIR_PATH="$(mktemp -p ${DATA_DIR_PATH} -d)/"
echo "${SCRIPT_NAME}: TMP_DIR_PATH: $TMP_DIR_PATH"

cleanup() {
    echo "${SCRIPT_NAME}: Cleaning up temporary files..."
    rm -rf "$TMP_DIR_PATH"
}

# スクリプト終了時・異常終了時に cleanup を実行
trap cleanup EXIT INT TERM

# main
echo "${SCRIPT_NAME}: $OUTPUT_FILE_PATH"
echo "${SCRIPT_NAME}: $INPUT_FILE_PATH"

exit 0


