#!/bin/bash

# Get current timestamp in YYYY-MM-DD HH:MM:SS format.
get_current_datetime() {
  date "+%Y-%m-%d %H:%M:%S"
}

# Log a message with timestamp.
log_message() {
  echo "$(get_current_datetime) $*"
}

# Log an info message.
log_info() {
  log_message "INFO: $*"
}

# Log a debug message if DEBUG is true.
log_debug() {
  if [ "$DEBUG" = "true" ]; then
    log_message "DEBUG: $*"
  fi
}

# Log an error message to stderr.
log_error() {
  log_message "ERROR: $*" >&2
}
