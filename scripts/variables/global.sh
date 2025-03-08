#!/bin/bash
set -e # Abort if there is an issue with any build.

# The url of the local repository.
REGISTRY_URL=""

# If the container will need internet from the host.
# HOST_PROXY="--add-host host.docker.internal=host-gateway"
HOST_PROXY=""

# The file that will receive the logs of each build.
LOG_BUILD_PATH="logs/build.log"
LOG_PUSH_PATH="logs/push.log"
