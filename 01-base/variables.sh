#!/bin/bash
set -e # Abort if there is an issue with any build.

IMAGE_NAME="lsampaioweb/alpine-base"
IMAGE_TAG="3.21-1.0"

IMAGE_FULLNAME="${REGISTRY_URL}${IMAGE_NAME}:${IMAGE_TAG}"

EXTRA_ARGS="${HOST_PROXY}"
