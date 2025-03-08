#!/bin/bash
set -e # Abort if there is an issue with any build.

IMAGE_NAME="lsampaioweb/alpine-springboot"
IMAGE_TAG="jre-21-1.0"

IMAGE_FULLNAME="${REGISTRY_URL}${IMAGE_NAME}:${IMAGE_TAG}"

BUILD_ARG=""

EXTRA_ARGS="${HOST_PROXY} ${BUILD_ARG}"
