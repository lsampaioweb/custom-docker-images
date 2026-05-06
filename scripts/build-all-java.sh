#!/bin/bash
set -e # Abort if there is an issue with any build.
set -o pipefail # Abort if any command in a pipeline fails.

# Helper script to build all Java images in sequence.

# Source logging functions.
. $(dirname "$BASH_SOURCE")/libs/log.sh

log_info "Starting build process for Java images."

log_info "Building java/01-base."
./scripts/build.sh java 01-base

log_info "Building java/02-runtime."
./scripts/build.sh java 02-runtime 21
./scripts/build.sh java 02-runtime 25

log_info "Building java/03-dev."
./scripts/build.sh java 03-dev 21
./scripts/build.sh java 03-dev 25

log_info "Building java/04-build."
./scripts/build.sh java 04-build 21
./scripts/build.sh java 04-build 25

log_info "Building java/05-console."
./scripts/build.sh java 05-console 21
./scripts/build.sh java 05-console 25

log_info "Building java/06-web."
./scripts/build.sh java 06-web 21
./scripts/build.sh java 06-web 25

log_info "All Java images built successfully."
