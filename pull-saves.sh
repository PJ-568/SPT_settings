#!/bin/sh

WORK_DIR=$(pwd)

# 更新设置目录
cd "$WORK_DIR" && git pull -f && exit 0

exit 1