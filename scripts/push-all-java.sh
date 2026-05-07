#!/bin/bash
set -e # Abort if there is an issue with any build.
set -o pipefail # Abort if any command in a pipeline fails.

# Helper script to push all Java images to the registry using auto-discovery.

# Source logging functions.
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=./scripts/libs/log.sh
. "${SCRIPT_DIR}/libs/log.sh"
# shellcheck source=./scripts/libs/container.sh
. "${SCRIPT_DIR}/libs/container.sh"
# shellcheck source=./scripts/variables/global.sh
. "${SCRIPT_DIR}/variables/global.sh"

log_info "Starting push process for Java images."

REFERENCE_URL="${REGISTRY_URL}/${ORGANIZATION_PREFIX}/java"

push_all_images "$REFERENCE_URL"

log_info "All Java images pushed successfully."
