#!/bin/bash
set -euo pipefail

source "$(dirname "$0")/../.env"

TIMESTAMP=$(date +"%Y-%m-%d")
mkdir -p "$BACKUP_DIR" "$LOG_DIR"

BACKUP_FILE="$BACKUP_DIR/student-api-backup-$TIMESTAMP.tar.gz"
LOG_FILE="$LOG_DIR/backup.log"

log_message() {
  echo "[$(date "+%Y-%m-%d %H:%M:%S")] $1" | tee -a "$LOG_FILE"
}

log_message "Backup started."

if [ -d "$PROJECT_DIR" ]; then
  tar -czf "$BACKUP_FILE" -C "$(dirname "$PROJECT_DIR")" "$(basename "$PROJECT_DIR")"
  log_message "Backup completed: $BACKUP_FILE"
else
  log_message "Project directory does not exist: $PROJECT_DIR"
fi
