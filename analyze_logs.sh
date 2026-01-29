#!/usr/bin/bash

LOG_DIR="hospital_data/active_logs"
REPORT="reports/analysis_report.txt"

mkdir -p reports

echo "Select log file to analyze:"
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"
read -p "Enter choice (1-3): " choice

case $choice in
  1)
    FILE="$LOG_DIR/heart_rate.log"
    TITLE="Heart Rate Analysis"
    ;;
  2)
    FILE="$LOG_DIR/temperature.log"
    TITLE="Temperature Analysis"
    ;;
  3)
    FILE="$LOG_DIR/water_usage.log"
    TITLE="Water Usage Analysis"
    ;;
  *)
    echo "❌ Invalid choice"
    exit 1
    ;;
esac

if [ ! -f "$FILE" ]; then
  echo "❌ Log file not found"
  exit 1
fi

{
  echo "=============================="
  echo "$TITLE - $(date)"
  echo "=============================="

  awk '{print $2}' "$FILE" | sort | uniq -c | while read count device
  do
    echo "Device $device: $count entries"
  done

  echo "First entry: $(head -n 1 "$FILE" | awk '{print $1}')"
  echo "Last entry: $(tail -n 1 "$FILE" | awk '{print $1}')"
  echo
} >> "$REPORT"

echo "✅ Analysis saved to $REPORT"
