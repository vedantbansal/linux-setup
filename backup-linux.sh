#!/bin/bash

log_message() {
  local message="$1"
  logger -t "DirectoryCopyScript" "$message"
  echo $message >> "/var/log/drive_backup.log" 
}

# Directories
SRC_DIR="/home/pebble"
DEST_DIR="/media/pebble/Seagate/linux-backup"

# Check if source and destination directories exist
if [ ! -d "$SRC_DIR" ]; then
  echo "Source directory $SRC_DIR does not exist."
  exit 1
fi

if [ ! -d "$DEST_DIR" ]; then
  echo "Destination directory $DEST_DIR does not exist."
  exit 1
fi

# Copy files from SRC_DIR to DEST_DIR if they do not exist or are newer
rsync -av --update "$SRC_DIR/" "$DEST_DIR/"

# Explanation of rsync options:
# -a: Archive mode; equals -rlptgoD (no -H,-A,-X), preserves symlinks, permissions, timestamps, etc.
# -v: Verbose; provides more information during the transfer
# --update: Skip files that are newer on the receiver (i.e., DEST_DIR)

log_message "Backup successful on $(date '+%Y-%m-%d %H:%M:%S')."
echo "Files copied successfully."

