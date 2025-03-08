#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./build.sh

# Load the file with the common variables and functions.
. $(dirname "$0")/../scripts/build.sh
. $(dirname "$0")/variables.sh

dockerBuild "${IMAGE_FULLNAME}" "${EXTRA_ARGS}"
