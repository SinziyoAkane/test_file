#!/bin/bash

# ==============================
# Multi-host Ping Script  
# ==============================

set +e  # 不因为错误退出（保证能执行到最后）

LOG_FILE="./ping_task.log"

# 目标列表
TARGETS=(
    "www.baidu.com"
    "www.google.com"
    "www.github.com"
    "invalid.test.domain"
)

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

ping_host() {
    local host=$1
    log "Checking host: $host"

    ping -c 2 -W 2 "$host" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        log "SUCCESS: $host is reachable"
        return 0
    else
        log "FAILED: $host is unreachable, skipping..."
        return 1
    fi
}

process_hosts() {
    log "Starting host processing..."

    for host in "${TARGETS[@]}"; do
        ping_host "$host"

        # 不管成功失败，都继续循环
        sleep 1
    done

    log "All hosts processed"
}

final_task() {
    log "Executing final stage..."

    # 这里可以放一些收尾操作（示例）
    TOTAL=${#TARGETS[@]}
    log "Total hosts checked: $TOTAL"

    log "Script reached the end successfully"
}

main() {
    log "Script started"

    process_hosts

    final_task

    log "Script finished"
}

main "$@"