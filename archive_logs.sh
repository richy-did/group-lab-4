#!/bin/bash

ACTIVE_DIR="hospital_data/active_logs"
ARCHIVE_BASE="hospital_data/archives"

echo "Select log to archive:"
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"
read -p "Enter choice (1-3): " choice

timestamp=$(date +"%Y-%m-%d_%H:%M:%S")

case $choice in
  1)
    logfile="heart_rate.log"
    archive_dir="$ARCHIVE_BASE/heart_data_archive"
    prefix="heart_rate"
    ;;
  2)
    logfile="temperature.log"
    archive_dir="$ARCHIVE_BASE/temp_data_archive"
    prefix="temperature"
    ;;
  3)
    logfile="water_usage.log"
    archive_dir="$ARCHIVE_BASE/water_data_archive"
    prefix="water_usage"
    ;;
  *)
    echo "Invalid choice. Please select 1, 2, or 3."
    exit 1
    ;;
esac

active_file="$ACTIVE_DIR/$logfile"

# Check if the active log file exists
if [ ! -f "$active_file" ]; then
  echo "Error: Log file not found at $active_file"
  exit 1
fi

# Create archive directory if it doesn't exist
mkdir -p "$archive_dir" || {
  echo "Error: Could not create archive directory $archive_dir"
  exit 1
}

archived_file="$archive_dir/${prefix}_${timestamp}.log"

echo "Archiving $logfile..."

# Move log to archive
mv "$active_file" "$archived_file" || {
  echo "Error: Failed to archive log file."
  exit 1
}

# Recreate empty log file for continued monitoring
touch "$active_file" || {
  echo "Error: Failed to create new log file."
  exit 1
}

echo "Successfully archived to $archived_file"
