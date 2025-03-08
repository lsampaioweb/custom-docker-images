#!/bin/bash
set -e # Abort if there is an issue with any build.

IMAGE_NAME="lsampaioweb/alpine-maven"
MAVEN_APK_VERSION="3.9.9-r0"
IMAGE_TAG="jdk-21-mvn-${MAVEN_APK_VERSION}-1.0"

IMAGE_FULLNAME="${REGISTRY_URL}${IMAGE_NAME}:${IMAGE_TAG}"

BUILD_ARG="--build-arg MAVEN_APK_VERSION=maven=${MAVEN_APK_VERSION}"

EXTRA_ARGS="${HOST_PROXY} ${BUILD_ARG}"
