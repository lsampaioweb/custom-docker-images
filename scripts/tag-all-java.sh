#!/bin/bash
set -e # Abort if there is an issue with any build.
set -o pipefail # Abort if any command in a pipeline fails.

# Helper script to tag all Java images to the registry with specified tags.

# Source logging functions.
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=./scripts/libs/log.sh
. "${SCRIPT_DIR}/libs/log.sh"

log_info "Starting tag process for Java images."

log_info "Tagging java/01-base."
"${SCRIPT_DIR}/tag.sh" java 01-base alpine.3.23-latest alpine-latest latest

log_info "Tagging java/02-runtime."
"${SCRIPT_DIR}/tag.sh" java 02-runtime 21 21-alpine.3.23-latest 21-alpine-latest
"${SCRIPT_DIR}/tag.sh" java 02-runtime 25 25-alpine.3.23-latest 25-alpine-latest alpine-latest latest

log_info "Tagging java/03-dev."
"${SCRIPT_DIR}/tag.sh" java 03-dev 21 21-alpine.3.23-latest 21-alpine-latest
"${SCRIPT_DIR}/tag.sh" java 03-dev 25 25-alpine.3.23-latest 25-alpine-latest alpine-latest latest

log_info "Tagging java/04-build."
"${SCRIPT_DIR}/tag.sh" java 04-build 21 21-maven-alpine.3.23-latest 21-maven-alpine-latest
"${SCRIPT_DIR}/tag.sh" java 04-build 25 25-maven-alpine.3.23-latest 25-maven-alpine-latest alpine-latest latest

log_info "Tagging java/05-console."
"${SCRIPT_DIR}/tag.sh" java 05-console 21 21-alpine.3.23-latest 21-alpine-latest
"${SCRIPT_DIR}/tag.sh" java 05-console 25 25-alpine.3.23-latest 25-alpine-latest alpine-latest latest

log_info "Tagging java/06-web."
"${SCRIPT_DIR}/tag.sh" java 06-web 21 21-alpine.3.23-latest 21-alpine-latest
"${SCRIPT_DIR}/tag.sh" java 06-web 25 25-alpine.3.23-latest 25-alpine-latest alpine-latest latest

log_info "All Java images tagged successfully."
