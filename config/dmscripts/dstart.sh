#!/bin/bash

# Check if logging is enabled via a flag or environment variable
LOGGING_ENABLED=${1:-false} # Default to false if no argument provided

# Function to start rofi
start_rofi() {
  rofi -combi-modi run,window,drun -show combi -modi combi -dpi 1
}

# Execute rofi
start_rofi

# If logging is enabled, output logs to the current directory
if [ "$LOGGING_ENABLED" = true ]; then
  echo "$(date) - Rofi was executed." >>./rofi.log
fi
