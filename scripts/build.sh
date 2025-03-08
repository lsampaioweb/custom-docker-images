#!/bin/bash
set -e # Abort if there is an issue with any build.

. $(dirname "$BASH_SOURCE")/libs/log.sh
. $(dirname "$BASH_SOURCE")/variables/global.sh

dockerBuild() {
  # $1 -> "${IMAGE_FULLNAME}"
  # $2 -> "${EXTRA_ARGS}"
  logInfo "Starting the build of $1."

  logInfo "docker build -t $1 $2 . 2>&1 | tee ${LOG_BUILD_PATH}"

  # Build the image.
  docker build -t $1 $2 . 2>&1 | tee ${LOG_BUILD_PATH}

  logInfo "Build finished."
}
