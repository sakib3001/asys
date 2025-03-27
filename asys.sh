#!/bin/bash

# CLI Structure and the System Monitoring Commands (week-01)
set -e
set -u

# --help or -h
show_help() {
  echo "Usage: asys [OPTION]"
  echo "A simple yet robust system monitoring CLI tool."
  echo "Options:"
  echo "   --cpu                    Show CPU usages"
  echo "   --ram                    Show Memory usages"
  echo "   --disk                   Show Disk  usages"
  echo "   --net                    Show Network usages"
  echo "   --help                   Show help menu"
}

show_ram() {
  clear
  if ! command -v free &>/dev/null; then
    echo -e "\033[31mError: 'free' command not found\!\033[0m"
    return 1
  fi

  tput civis # Hide cursor for smooth updates

  while true; do
    tput cup 0 0 # Move cursor to top instead of clearing screen
    total=$(free -m | awk 'NR==2 {print $2}')
    used=$(free -m | awk 'NR==2 {print $3}')
    free=$(free -m | awk 'NR==2 {print $4}')
    buff_cache=$(free -m | awk 'NR==2 {print $6}')
    available=$(free -m | awk 'NR==2 {print $7}')
    actual_used=$(echo "$total - $available" | bc)
    used_percent=$(echo "scale=2; ($actual_used/$total) * 100" | bc)

    if (($(echo "$used_percent >= 90" | bc -l))); then
      color="\033[31m"
      status="🔥 CRITICAL"
    elif (($(echo "$used_percent >= 75" | bc -l))); then
      color="\033[33m"
      status="⚠️ HIGH"
    else
      color="\033[32m"
      status="✅ NORMAL"
    fi

    echo "---------------------------------"
    echo -e "📊 Memory Usage Info:"
    echo "---------------------------------"
    echo "Total RAM:       $total MB"
    echo "Used (Actual):   $actual_used MB"
    echo "Available:       $available  MB"
    echo "Usage Percent:   $used_percent%"
    echo -e "Status:       ${color}$status\033[0m"
    echo "---------------------------------"
    sleep 2
  done
  tput cnorm # Restore cursor

}

case "${1}" in
--cpu) echo "cpu is showing" ;;
--ram) show_ram ;;
--disk) echo "disk is showing" ;;
--net) echo "net is showing" ;;
--help) show_help ;;
*) echo "Invalid Option. Use --help to see available commands." ;;
esac
