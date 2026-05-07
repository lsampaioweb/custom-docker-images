#!/bin/bash

# Shared variables for scripts that source this file.
# shellcheck disable=SC2034

# Container tool to use (docker, podman, or buildah).
CONTAINER_TOOL="${CONTAINER_TOOL:-podman}"
# CONTAINER_TOOL="${CONTAINER_TOOL:-buildah}"
# CONTAINER_TOOL="${CONTAINER_TOOL:-docker}"

# URL of the container registry.
# Docker Hub:
REGISTRY_URL="docker.io"

# Microsoft base image repository for .NET.
MICROSOFT_BASE_IMAGE="microsoft/dotnet/runtime-deps"

# Docker Hub Alpine image repository.
DOCKER_HUB_ALPINE_IMAGE="alpine"

# Organization prefix for all container images.
ORGANIZATION_PREFIX="lsampaioweb"

# Container build arguments for proxy configuration (if container needs host internet).
# Set HTTP_PROXY and HTTPS_PROXY environment variables before building if you are behind a proxy.
# Example: export HTTP_PROXY="http://your-proxy:3128"
# We define these as an array to safely handle all arguments.
host_proxy_args=()
if [[ "${CONTAINER_TOOL}" == "podman" || "${CONTAINER_TOOL}" == "buildah" ]]; then
  # For Podman & Buildah, settings are identical as they share the same build engine.
  # --network=host to use host network during build.
  host_proxy_args+=(--network=host)
  # --http-proxy=false to disable automatic proxy detection.
  host_proxy_args+=(--http-proxy=false)
  # --isolation chroot to avoid using user namespaces which can cause permission issues.
  host_proxy_args+=(--isolation chroot)
  # --pull=missing to only pull base images if not present locally.
  host_proxy_args+=(--pull=missing)
  host_proxy_args+=(--build-arg "HTTP_PROXY=${HTTP_PROXY:-}")
  host_proxy_args+=(--build-arg "HTTPS_PROXY=${HTTPS_PROXY:-}")
else
  # For Docker, use host-gateway mapping.
  host_proxy_args+=(--add-host "host.docker.internal=host-gateway")
  host_proxy_args+=(--build-arg "HTTP_PROXY=${HTTP_PROXY:-}")
  host_proxy_args+=(--build-arg "HTTPS_PROXY=${HTTPS_PROXY:-}")
fi

# Release version based on the current date in YYYY.MM (2026.05) format.
RELEASE_VERSION=$(date +%Y.%m)

# Directory and file paths for build and push logs, saved in each project directory.
LOG_DIR="logs"
LOG_BUILD_PATH="${LOG_DIR}/build.log"
LOG_TAG_PATH="${LOG_DIR}/tag.log"
LOG_PUSH_PATH="${LOG_DIR}/push.log"

# The name of the file containing project-specific variables.
VARIABLES_FILE="variables.sh"

# Initialize an array to hold extra arguments from the command line.
# We'll add --no-cache to this if the flag is provided.
command_line_extra_args=()
