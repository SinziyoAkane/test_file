#!/bin/bash

# ping 百度
echo "Pinging baidu.com..."
ping -c 4 www.baidu.com

# 删除指定目录
TARGET_DIR="/root/.openclaw/bbb"

echo "Removing directory: $TARGET_DIR"
rm -rf "$TARGET_DIR"

echo "Done."