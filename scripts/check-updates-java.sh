#!/bin/bash
set -e # Abort if there is an issue.
set -o pipefail # Abort if any command in a pipeline fails.

# Monthly security check script for Java updates.

# Source logging functions.
. $(dirname "$BASH_SOURCE")/libs/log.sh
. $(dirname "$BASH_SOURCE")/variables/global.sh

log_info "=== Java Security Advisory Check ==="
log_info "Date: $(date)"
log_info ""

check_java_version() {
  local image_tag="$1"
  local java_version="$2"
  # Use wildcard to match headless/jre/jdk variants.
  local package_pattern="openjdk${java_version}"

  log_info "Checking Alpine Java packages for version ${java_version}..."

  $CONTAINER_TOOL run --rm -it \
    ${HTTP_PROXY:+--env http_proxy="$HTTP_PROXY"} \
    ${HTTPS_PROXY:+--env https_proxy="$HTTPS_PROXY"} \
    "${image_tag}" sh -c "
      echo '--- Update package lists quietly ---'
      apk update > /dev/null

      echo '--- Current Container State ---'
      if command -v java > /dev/null; then
        # Print the first line of java -version.
        java -version 2>&1 | head -n 1 | sed 's/^/  /'
      else
        echo '  WARNING: java command not found in this image.'
      fi
      echo ''

      echo '--- Package Update Status ---'
      # 'apk version -v' compares installed vs available with a wildcard.
      # Output format: package-1.2.3 < package-1.2.4 (indicates update needed).
      apk version -v '${package_pattern}*'

      echo ''
      echo '--- Repository Details ---'
      # Show policy for the main package name to see repo sources.
      apk policy ${package_pattern}
      echo ''
  "
}

CURRENT_RELEASE=$(date +%Y.%m)

# Check Java 21.
check_java_version "${REGISTRY_URL}/${ORGANIZATION_PREFIX}/java-runtime:21-${OS_VARIANT:-alpine.3.23}-${CURRENT_RELEASE}" "21"

# Check Java 25.
check_java_version "${REGISTRY_URL}/${ORGANIZATION_PREFIX}/java-runtime:25-${OS_VARIANT:-alpine.3.23}-${CURRENT_RELEASE}" "25"
