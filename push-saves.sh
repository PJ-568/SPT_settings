#!/bin/sh

WORK_DIR=$(pwd)

# 返回设置目录并提交更改
cd "$WORK_DIR" && git add -A && git commit -m "【更新存档】$(date "+%Y-%m-%d %H:%M:%S")" && git push -f && exit 0

exit 1