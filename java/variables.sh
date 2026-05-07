#!/bin/bash

# Shared variables for Java image-specific variables.sh files that source this file.
# shellcheck disable=SC2034

# Java project-wide defaults.

# Project configuration.
# Docker Hub uses a flat 2-level naming: {ORGANIZATION_PREFIX}/{lang}-{component}
# Example: lsampaioweb/java-base, lsampaioweb/java-runtime, lsampaioweb/java-dev
BASE_IMAGE_PREFIX="${ORGANIZATION_PREFIX}"

# Common defaults for this project.
# Alpine 3.23 base images.
OS_VARIANT_VERSION="3.23"
OS_VARIANT="alpine.${OS_VARIANT_VERSION}"

# Component name mappings for Java.
# The "java-" prefix ensures unique Docker Hub repository names per technology.
COMPONENT_BASE_NAME="java-base"       # Base image with CA certificates and minimal setup.
COMPONENT_DEV_NAME="java-dev"         # Maps to JDK functionality.
COMPONENT_RUNTIME_NAME="java-runtime" # Maps to JRE functionality.
COMPONENT_BUILD_NAME="java-build"     # Dev + CI tools.
COMPONENT_CONSOLE_NAME="java-console" # Maps to Java console applications.
COMPONENT_WEB_NAME="java-web"         # Maps to SpringBoot functionality.
