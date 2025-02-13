#!/usr/bin/env bash

WORK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 更新设置目录
cd "$WORK_DIR" && git pull -f && exit 0

exit 1