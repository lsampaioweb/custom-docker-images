#!/bin/bash
set -e # Abort if there is an issue with any build.
set -o pipefail # Abort if any command in a pipeline fails.

# Helper script to build all Java images in sequence.

# Source logging functions.
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=./scripts/libs/log.sh
. "${SCRIPT_DIR}/libs/log.sh"

log_info "Starting build process for Java images."

log_info "Building java/01-base."
"${SCRIPT_DIR}/build.sh" java 01-base

log_info "Building java/02-runtime."
"${SCRIPT_DIR}/build.sh" java 02-runtime 21
"${SCRIPT_DIR}/build.sh" java 02-runtime 25

log_info "Building java/03-dev."
"${SCRIPT_DIR}/build.sh" java 03-dev 21
"${SCRIPT_DIR}/build.sh" java 03-dev 25

log_info "Building java/04-build."
"${SCRIPT_DIR}/build.sh" java 04-build 21
"${SCRIPT_DIR}/build.sh" java 04-build 25

log_info "Building java/05-console."
"${SCRIPT_DIR}/build.sh" java 05-console 21
"${SCRIPT_DIR}/build.sh" java 05-console 25

log_info "Building java/06-web."
"${SCRIPT_DIR}/build.sh" java 06-web 21
"${SCRIPT_DIR}/build.sh" java 06-web 25

log_info "All Java images built successfully."
