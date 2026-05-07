#!/bin/bash
set -e # Abort if there is an issue with any build.
set -o pipefail # Abort if any command in a pipeline fails.

# Usage:
# ./build.sh [--no-cache] [--debug] <project_type> <project_name> [project_version]

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"

# shellcheck source=./scripts/libs/log.sh
. "${SCRIPT_DIR}/libs/log.sh"
# shellcheck source=./scripts/libs/directory.sh
. "${SCRIPT_DIR}/libs/directory.sh"
# shellcheck source=./scripts/variables/global.sh
. "${SCRIPT_DIR}/variables/global.sh"
# shellcheck source=./scripts/libs/common.sh
. "${SCRIPT_DIR}/libs/common.sh"

if ! parse_common_args "$@"; then
  # Print the specific usage message for build.sh.
  log_error "Usage: $0 [--no-cache] [--debug] <project_type> <project_name> [project_version]"
  exit 1
fi

cd "${REPO_ROOT}"

# Populated by sourced project variables.sh.
IMAGE_FULLNAME="${IMAGE_FULLNAME:-}"

run_build() {
  local project_dir="$1"
  local image_fullname="$2"
  local log_path="${project_dir}/${LOG_BUILD_PATH}"

  # Remove the first two arguments, leaving the rest of the build args in "$@".
  shift 2

  # Ensure log directory exists.
  create_directory "${project_dir}/${LOG_DIR}"

  log_info "Starting the build of $image_fullname." | tee "${log_path}"

  # Format the command with proper quoting for the log file.
  local formatted_args
  printf -v formatted_args "%q " "$@"
  log_info "Running: ${CONTAINER_TOOL} build -t ${image_fullname} ${formatted_args}${project_dir} 2>&1 | tee ${log_path}" | tee -a "${log_path}"

  # Build the image and save output to log file.
  # "$@" expands the array safely, with each element becoming a distinct argument.
  $CONTAINER_TOOL build -t "$image_fullname" "$@" "$project_dir" 2>&1 | tee -a "${log_path}"

  log_info "Build finished." | tee -a "${log_path}"
}

# Assemble all arguments from different sources into one final array.
build_args=()
build_args+=("${host_proxy_args[@]}")
build_args+=("${project_build_args[@]}")
build_args+=("${command_line_extra_args[@]}")

run_build "$project_dir" "$IMAGE_FULLNAME" "${build_args[@]}"
