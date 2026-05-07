#!/bin/bash
set -e # Abort if there is an issue with any build.
set -o pipefail # Abort if any command in a pipeline fails.

# Usage:
# ./tag.sh [--debug] <project_type> <project_name> [project_version] [extra_tags...]

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
  # Print the specific usage message for tag.sh.
  log_error "Usage: $0 [--debug] <project_type> <project_name> [project_version] [extra_tags...]"
  exit 1
fi

cd "${REPO_ROOT}"

# Populated by sourced project variables.sh.
IMAGE_FULLNAME="${IMAGE_FULLNAME:-}"

run_tag() {
  local project_dir="$1"
  local image_fullname="$2"
  local log_path="${project_dir}/${LOG_TAG_PATH}"

  # Shift past the first two arguments ($current_project_dir and $image_fullname)
  # Extra tags are now in $@.
  shift 2

  # Ensure log directory exists.
  create_directory "${project_dir}/${LOG_DIR}"

  log_info "Starting tagging of $image_fullname." | tee "${log_path}"

  # Iterate over the captured extra tags array.
  for tag in "$@"; do
    # Replace version with new tag.
    # E.g., if image_fullname is myimage:1.0 and tag is latest: tagged_image becomes myimage:latest.
    local tagged_image="${image_fullname%:*}:$tag"

    log_info "Running: $CONTAINER_TOOL tag $image_fullname $tagged_image 2>&1 | tee -a ${log_path}" | tee -a "${log_path}"
    $CONTAINER_TOOL tag "$image_fullname" "$tagged_image" 2>&1 | tee -a "${log_path}"
  done

  log_info "Tag finished." | tee -a "${log_path}"
}

run_tag "$project_dir" "$IMAGE_FULLNAME" "${COMMON_EXTRA_ARGS[@]}"
