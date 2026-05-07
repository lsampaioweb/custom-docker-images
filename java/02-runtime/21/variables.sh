#!/bin/bash
set -e # Abort if there is an issue with any build.
set -o pipefail # Abort if any command in a pipeline fails.

# This file is sourced by the main build/tag scripts.
# shellcheck disable=SC2034

# Source project defaults.
# shellcheck disable=SC1090,SC2154
source "$project_type/$VARIABLES_FILE"

# Version and component specifics.
COMPONENT_NAME="${COMPONENT_RUNTIME_NAME}"
CODE_VERSION="21"

# Construct the parent image tag for FROM statement.
PARENT_IMAGE_TAG="${OS_VARIANT}-${RELEASE_VERSION}"
PARENT_IMAGE_FULLNAME=${REGISTRY_URL}/${BASE_IMAGE_PREFIX}/${COMPONENT_BASE_NAME}:${PARENT_IMAGE_TAG}

# Java runtime package.
PACKAGE="openjdk21-jre-headless"

# Construct image name and tag using inherited variables.
IMAGE_NAME="${BASE_IMAGE_PREFIX}/${COMPONENT_NAME}"

# Construct the image tag using variables.
IMAGE_TAG="${CODE_VERSION}-${OS_VARIANT}-${RELEASE_VERSION}"

# Construct the full image name with registry URL.
# shellcheck disable=SC2034
IMAGE_FULLNAME="${REGISTRY_URL}/${IMAGE_NAME}:${IMAGE_TAG}"

# Build arguments for the Dockerfile as an array.
project_build_args=()
project_build_args+=(--build-arg "PARENT_IMAGE_FULLNAME=${PARENT_IMAGE_FULLNAME}")
project_build_args+=(--build-arg "IMAGE_TAG=${IMAGE_TAG}")
project_build_args+=(--build-arg "PACKAGE=${PACKAGE}")
