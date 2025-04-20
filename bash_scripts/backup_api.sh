#!/bin/bash
set -euo pipefail

source /opt/server-maintenance/.env

mkdir -p "$BACKUP_DIR"

read -sp "Enter PostgreSQL password for user '$DB_USER': " PGPASSWORD
echo
export PGPASSWORD

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

API_BACKUP_FILE="$BACKUP_DIR/api_backup_$(date +%F).tar.gz"
tar -czf "$API_BACKUP_FILE" "$API_DIR"
API_BACKUP_STATUS=$?

DB_BACKUP_FILE="$BACKUP_DIR/db_backup_$(date +%F).sql"
pg_dump -U "$DB_USER" -F p "$DB_NAME" > "$DB_BACKUP_FILE"
DB_BACKUP_STATUS=$?

find "$BACKUP_DIR" -type f -mtime +7 -delete

if [ $API_BACKUP_STATUS -eq 0 ] && [ $DB_BACKUP_STATUS -eq 0 ]; then
  echo "[$TIMESTAMP] Backup completed successfully." >> "$LOG_FILE"
else
  echo "[$TIMESTAMP] Backup failed!" >> "$LOG_FILE"
fi
