#!/bin/bash
set -euo pipefail

source "$(dirname "$0")/../.env"

LOG_FILE="$LOG_DIR/server_health.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

mkdir -p "$LOG_DIR"

log_message() {
  echo "[$TIMESTAMP] $1" | tee -a "$LOG_FILE"
}

check_cpu_usage() {
  CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
  if (( $(echo "$CPU_USAGE > 90" | bc -l) )); then
    log_message "High CPU usage: $CPU_USAGE%"
  else
    log_message "CPU usage: $CPU_USAGE%"
  fi
}

check_memory_usage() {
  MEMORY_USAGE=$(free | awk '/Mem/ {print $3/$2 * 100.0}')
  if (( $(echo "$MEMORY_USAGE > 90" | bc -l) )); then
    log_message "High memory usage: $MEMORY_USAGE%"
  else
    log_message "Memory usage: $MEMORY_USAGE%"
  fi
}

check_disk_space() {
  DISK_USAGE=$(df -h / | awk 'NR==2 {gsub("%",""); print $5}')
  if [ "$DISK_USAGE" -gt 80 ]; then
    log_message "Disk usage high: $DISK_USAGE%"
  else
    log_message "Disk usage: $DISK_USAGE%"
  fi
}

check_web_server() {
  if systemctl is-active --quiet "$SERVICE_NAME"; then
    log_message "$SERVICE_NAME is running."
  else
    log_message "$SERVICE_NAME is not running."
  fi
}

check_api_endpoints() {
  if curl --silent --fail "$API_ENDPOINT" > /dev/null; then
    log_message "API endpoint is up."
  else
    log_message "API endpoint is down."
  fi
}

log_message "Health check started."
check_cpu_usage
check_memory_usage
check_disk_space
check_web_server
check_api_endpoints
log_message "Health check completed."
