#!/bin/bash

# Create a directory if it doesn't exist.
create_directory() {
  local dir="$1"
  if [[ ! -d "$dir" ]]; then
    log_debug "Creating directory: $dir."

    if ! mkdir -p "$dir" 2>/dev/null; then
      log_error "Failed to create directory $dir."
      exit 1
    fi
  fi
}
