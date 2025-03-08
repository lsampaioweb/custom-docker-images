#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./push.sh

# Load the file with the common variables and functions.
. $(dirname "$0")/../scripts/push.sh
. $(dirname "$0")/variables.sh

dockerPush "${IMAGE_FULLNAME}"
