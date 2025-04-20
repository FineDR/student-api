#!/bin/bash
set -euo pipefail

source /opt/server-maintenance/.env
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

log_message() {
  echo "[$TIMESTAMP] $1" >> "$LOG_FILE"
}

check_cpu_usage() {
  CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
  if (( $(echo "$CPU_USAGE > 90" | bc -l) )); then
    log_message "WARNING: High CPU usage: $CPU_USAGE%"
  else
    log_message "CPU usage: $CPU_USAGE%"
  fi
}

check_memory_usage() {
  MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
  if (( $(echo "$MEMORY_USAGE > 90" | bc -l) )); then
    log_message "WARNING: High memory usage: $MEMORY_USAGE%"
  else
    log_message "Memory usage: $MEMORY_USAGE%"
  fi
}

check_disk_space() {
  DISK_USAGE=$(df -h | grep '/$' | awk '{print $5}' | sed 's/%//')
  if [ "$DISK_USAGE" -gt 80 ]; then
    log_message "WARNING: Low disk space: $DISK_USAGE% used"
  else
    log_message "Disk usage: $DISK_USAGE% used"
  fi
}

check_web_server() {
  if systemctl is-active --quiet nginx; then
    log_message "Nginx is running."
  else
    log_message "ERROR: Nginx is not running!"
  fi
}

check_api_endpoints() {
  if curl --silent --fail http://localhost/api/subjects/ > /dev/null; then
    log_message "API endpoint is up."
  else
    log_message "ERROR: API endpoint is down!"
  fi
}

log_message "Health check started."
check_cpu_usage
check_memory_usage
check_disk_space
check_web_server
check_api_endpoints
log_message "Health check completed."
