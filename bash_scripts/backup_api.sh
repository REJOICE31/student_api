#!/bin/bash

# Define variables
BACKUP_DIR="/home/ubuntu/backups"
PROJECT_DIR="/home/ubuntu/projects/student_api"
DB_FILE="$PROJECT_DIR/db.sqlite3"
DATE=$(date +%F)
API_BACKUP="$BACKUP_DIR/api_backup_$DATE.tar.gz"
DB_BACKUP="$BACKUP_DIR/db_backup_$DATE.sqlite3"
LOG_FILE="/var/log/backup.log"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Start logging
{
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting backup..."

    # Backup project files
    if tar -czf "$API_BACKUP" "$PROJECT_DIR"; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Project backup created: $API_BACKUP"
    else
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Failed to create project backup!"
    fi

    # Backup database file
    if cp "$DB_FILE" "$DB_BACKUP"; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Database backup created: $DB_BACKUP"
    else
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Failed to backup database!"
    fi

    # Delete backups older than 7 days
    find "$BACKUP_DIR" -type f -mtime +7 -exec rm {} \;
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Old backups (7+ days) deleted."

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup process finished."
} >> "$LOG_FILE" 2>&1
