#!/usr/bin/env bash

# ==========================================================
# Systemd Service Helper
# Author: Ushan Perera
# Description:
# Manage and troubleshoot systemd services on Linux
# ==========================================================

set -euo pipefail

ACTION="${1:-status}"
SERVICE_NAME="${2:-}"
LOG_LINES="${3:-20}"

line() {
    printf '%*s\n' "${COLUMNS:-70}" '' | tr ' ' '='
}

section() {
    echo
    line
    echo "$1"
    line
}

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

usage() {
    cat <<EOF
Usage:
  $0 status <service>
  $0 restart <service>
  $0 start <service>
  $0 stop <service>
  $0 enable <service>
  $0 disable <service>
  $0 logs <service> [lines]
  $0 failed
  $0 list-running
EOF
}

require_systemd() {
    if ! command -v systemctl >/dev/null 2>&1; then
        echo "systemctl is not available on this system."
        exit 1
    fi
}

require_service_name() {
    if [[ -z "$SERVICE_NAME" ]]; then
        echo "Service name is required for action: $ACTION"
        usage
        exit 1
    fi
}

show_status() {
    section "SERVICE STATUS: ${SERVICE_NAME}"
    systemctl status "$SERVICE_NAME" --no-pager
}

restart_service() {
    section "RESTARTING SERVICE: ${SERVICE_NAME}"
    systemctl restart "$SERVICE_NAME"
    log "Service restarted successfully: ${SERVICE_NAME}"
    systemctl status "$SERVICE_NAME" --no-pager
}

start_service() {
    section "STARTING SERVICE: ${SERVICE_NAME}"
    systemctl start "$SERVICE_NAME"
    log "Service started successfully: ${SERVICE_NAME}"
    systemctl status "$SERVICE_NAME" --no-pager
}

stop_service() {
    section "STOPPING SERVICE: ${SERVICE_NAME}"
    systemctl stop "$SERVICE_NAME"
    log "Service stopped successfully: ${SERVICE_NAME}"
    systemctl status "$SERVICE_NAME" --no-pager || true
}

enable_service() {
    section "ENABLING SERVICE: ${SERVICE_NAME}"
    systemctl enable "$SERVICE_NAME"
    log "Service enabled successfully: ${SERVICE_NAME}"
}

disable_service() {
    section "DISABLING SERVICE: ${SERVICE_NAME}"
    systemctl disable "$SERVICE_NAME"
    log "Service disabled successfully: ${SERVICE_NAME}"
}

show_logs() {
    section "SERVICE LOGS: ${SERVICE_NAME}"
    journalctl -u "$SERVICE_NAME" -n "$LOG_LINES" --no-pager
}

show_failed_services() {
    section "FAILED SYSTEMD SERVICES"
    systemctl --failed --no-pager
}

list_running_services() {
    section "RUNNING SYSTEMD SERVICES"
    systemctl list-units --type=service --state=running --no-pager
}

main() {
    require_systemd

    case "$ACTION" in
        status)
            require_service_name
            show_status
            ;;
        restart)
            require_service_name
            restart_service
            ;;
        start)
            require_service_name
            start_service
            ;;
        stop)
            require_service_name
            stop_service
            ;;
        enable)
            require_service_name
            enable_service
            ;;
        disable)
            require_service_name
            disable_service
            ;;
        logs)
            require_service_name
            show_logs
            ;;
        failed)
            show_failed_services
            ;;
        list-running)
            list_running_services
            ;;
        *)
            echo "Invalid action: $ACTION"
            usage
            exit 1
            ;;
    esac
}

main "$@"
