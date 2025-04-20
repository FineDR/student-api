#!/bin/bash
set -euo pipefail

source /opt/server-maintenance/.env
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

echo "[$TIMESTAMP] Update started." >> "$LOG_FILE"

sudo apt update && sudo apt upgrade -y >> "$LOG_FILE" 2>&1

cd "$REPO_DIR"
if ! git pull origin main >> "$LOG_FILE" 2>&1; then
  echo "[$TIMESTAMP] ERROR: Git pull failed!" >> "$LOG_FILE"
  exit 1
fi

sudo systemctl restart apache2
echo "[$TIMESTAMP] Update completed." >> "$LOG_FILE"
