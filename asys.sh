#!/bin/bash

# CLI Structure and the System Monitoring Commands (week-01)

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

case "${1}" in
--cpu) echo "cpu is showing" ;;
--ram) echo "ram is showing" ;;
--disk) echo "disk is showing" ;;
--net) echo "net is showing" ;;
--help) show_help ;;
*) echo "Invalid Option. Use --help to see available commands." ;;
esac
