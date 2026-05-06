#!/bin/bash

# Common setup and argument parsing for build.sh and tag.sh

# Enable script trace when requested via --debug.
DEBUG_MODE="${DEBUG_MODE:-false}"

# Process all option flags before positional arguments.
# This loop correctly handles any combination and order of flags (e.g., --no-cache --debug or --debug --no-cache).
while [[ "$1" == --* ]]; do
  case "$1" in
    --no-cache) command_line_extra_args+=(--no-cache) ;;
    --debug)    DEBUG_MODE="true" ;;
    *)
      log_error "Unknown option: $1"
      return 1
      ;;
  esac
  shift
done

if [[ "$DEBUG_MODE" == "true" ]]; then
  # shellcheck disable=SC3040
  set -x
fi

# Check if at least 2 non-empty arguments are provided.
if [ "$#" -lt 2 ] || [ -z "$1" ] || [ -z "$2" ]; then
  return 1
fi

project_type="$1"
project_name="$2"
# The potential project_version is the 3rd argument.
potential_project_version="$3"

# Determine the directory containing the variables.sh file.
project_base_dir="$project_type/$project_name"

# Now, determine the actual project_version and the directory containing variables.sh.
# Assume no version initially.
project_version=""
project_dir="$project_base_dir"
# Assume extra tags start from the 3rd argument.
start_of_extra_tags_index=3

# If there is a 3rd argument, check if it corresponds to a version subdirectory.
if [ "$#" -ge 3 ]; then
  if [ -f "$project_base_dir/$potential_project_version/$VARIABLES_FILE" ]; then
    # If variables.sh exists in the potential version directory, then it's a version.
    project_version="$potential_project_version"
    project_dir="$project_base_dir/$project_version"
    # Extra tags start from the 4th argument.
    start_of_extra_tags_index=4
  fi
fi

# Load the project-specific and potentially version-specific variables.
# Source from the determined project_dir.
if [ -f "$project_dir/$VARIABLES_FILE" ]; then
  . "$project_dir/$VARIABLES_FILE"
else
  # Added error handling for missing variables.sh.
  log_error "$VARIABLES_FILE not found in $project_dir"

  # Provide more specific error if a version was specified but the directory/file is missing.
  if [ -n "$project_version" ]; then
    log_error "Make sure you have created the directory '$project_dir' and placed '$VARIABLES_FILE' inside it."
  fi
  # Indicate failure to the caller.
  return 1
fi

# Shift arguments to leave only extra_tags in $@.
# We shift based on where the extra tags are expected to start.
shift $((start_of_extra_tags_index - 1))
# Now $@ contains only the extra tags.

# Indicate success.
return 0
