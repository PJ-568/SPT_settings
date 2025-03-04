#!/usr/bin/env bash

WORK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 更新设置目录
cd "$WORK_DIR" || exit 1

# 检查本地是否有未提交修改
if [ -n "$(git status --porcelain)" ]; then
    ./push-saves.sh
    exit 0
fi

git pull -f && exit 0

exit 1