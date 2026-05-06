#!/bin/bash
set -e # Abort if there is an issue with any build.
set -o pipefail # Abort if any command in a pipeline fails.

# Helper script to push all Java images to the registry using auto-discovery.

# Source logging functions.
. $(dirname "$BASH_SOURCE")/libs/log.sh
. $(dirname "$BASH_SOURCE")/libs/container.sh
. $(dirname "$BASH_SOURCE")/variables/global.sh

log_info "Starting push process for Java images."

REFERENCE_URL="${REGISTRY_URL}/${ORGANIZATION_PREFIX}/java"

push_all_images "$REFERENCE_URL"

log_info "All Java images pushed successfully."
