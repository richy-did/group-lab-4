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
    echo "Invalid choice.Please choose among the available options."
    exit 1
    ;;
esac

