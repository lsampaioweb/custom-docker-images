#!/bin/bash
set -e # Abort if there is an issue with any build.

. $(dirname "$BASH_SOURCE")/libs/log.sh
. $(dirname "$BASH_SOURCE")/variables/global.sh

dockerPush() {
  # $1 -> "${IMAGE_FULLNAME}"
  logInfo "Starting the push of $1."

  logInfo "docker push $1 2>&1 | tee ${LOG_PUSH_PATH}"

  # Push to the local registry.
  docker push $1 2>&1 | tee ${LOG_PUSH_PATH}

  logInfo "Push finished."
}
