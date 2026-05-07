#!/bin/bash
set -e # Abort if there is an issue with any build.
set -o pipefail # Abort if any command in a pipeline fails.

# Helper script to push all images in sequence.

# Source logging functions.
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=./scripts/libs/log.sh
. "${SCRIPT_DIR}/libs/log.sh"

"${SCRIPT_DIR}/push-all-java.sh"

log_info "All images pushed successfully."
