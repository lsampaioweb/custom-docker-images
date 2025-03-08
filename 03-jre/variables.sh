#!/bin/bash
set -e # Abort if there is an issue with any build.

IMAGE_NAME="lsampaioweb/alpine-openjdk"
IMAGE_TAG="jre-21-1.0"
JAVA_PACKAGE="openjdk21-jre-headless"

IMAGE_FULLNAME="${REGISTRY_URL}${IMAGE_NAME}:${IMAGE_TAG}"

BUILD_ARG="--build-arg JAVA_PACKAGE=${JAVA_PACKAGE}"

EXTRA_ARGS="${HOST_PROXY} ${BUILD_ARG}"
