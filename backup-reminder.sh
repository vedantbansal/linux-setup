#!/bin/bash

# Log file path
LOG_FILE="/var/log/drive_backup.log"
export DISPLAY=:0


# Function to extract the last backup date from the log file
get_last_backup_date() {
  # Extract the last date entry from the log file, assuming the date format is YYYY-MM-DD
  last_backup_date=$(grep -oP '\d{4}-\d{2}-\d{2}' "$LOG_FILE" | tail -n 1)
  
  echo "$last_backup_date"
}

# Function to calculate days difference between today and the last backup date
calculate_days_difference() {
  local last_backup_date="$1"
  local current_date=$(date +%Y-%m-%d)

  # Convert dates to seconds since epoch
  local last_backup_date_epoch=$(date -d "$last_backup_date" +%s)
  local current_date_epoch=$(date -d "$current_date" +%s)

  # Calculate difference in days
  local difference=$(( (current_date_epoch - last_backup_date_epoch) / 86400 ))

  echo "$difference"
}

# Check if the log file exists
if [ ! -f "$LOG_FILE" ]; then
  echo "Log file $LOG_FILE does not exist."
  exit 1
fi

# Get the last backup date from the log file
last_backup_date=$(get_last_backup_date)

# Check if we have a valid date
if [ -z "$last_backup_date" ]; then
  echo "No valid backup date found in the log file."
  exit 1
fi

# Calculate the number of days since the last backup
days_difference=$(calculate_days_difference "$last_backup_date")

# Check if the last backup was more than 7 days ago
if [ "$days_difference" -gt 7 ]; then
  reminder_message="Reminder: The last backup was $days_difference days ago.  Please perform a new backup."
  
  notify-send "$reminder_message"
  
fi

