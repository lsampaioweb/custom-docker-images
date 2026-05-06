#!/bin/bash
set -e # Abort if there is an issue with any build.
set -o pipefail # Abort if any command in a pipeline fails.

# Helper script to build all images in sequence.

# Source logging functions.
. $(dirname "$BASH_SOURCE")/libs/log.sh

./scripts/build-all-java.sh

log_info "All images built successfully."
