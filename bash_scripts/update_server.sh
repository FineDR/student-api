#!/bin/bash
set -euo pipefail

source "$(dirname "$0")/../.env"

LOG_FILE="$LOG_DIR/update.log"
mkdir -p "$LOG_DIR"

log_message() {
  echo "[$(date "+%Y-%m-%d %H:%M:%S")] $1" | tee -a "$LOG_FILE"
}

log_message "Server update started."

if [ -d "$PROJECT_DIR" ]; then
  cd "$PROJECT_DIR"
  git pull origin main >> "$LOG_FILE" 2>&1
  log_message "Codebase updated."

  if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt >> "$LOG_FILE" 2>&1
    log_message "Dependencies installed."
  fi

  sudo systemctl restart "$SERVICE_NAME"
  log_message "$SERVICE_NAME restarted."
else
  log_message "Project directory not found: $PROJECT_DIR"
fi

log_message "Server update completed."
