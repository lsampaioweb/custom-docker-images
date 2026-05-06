#!/bin/bash

# List local container images whose name contains the given reference string.
# Usage: container_image_list "<reference_string>"
container_image_list() {
  local REFERENCE_URL="$1"

  if [[ "${CONTAINER_TOOL}" == "buildah" ]]; then
    ${CONTAINER_TOOL} images --format "{{.Name}}:{{.Tag}}" | grep "$REFERENCE_URL" | sort
  else
    ${CONTAINER_TOOL} image ls --format "{{.Repository}}:{{.Tag}}" | grep "$REFERENCE_URL" | sort
  fi
}

push_image() {
  local IMAGE="$1"

  log_info "Pushing: $IMAGE"
  $CONTAINER_TOOL push "$IMAGE"
}

push_all_images() {
  # Get the image reference URL.
  local REFERENCE_URL="$1"

  if [ -z "$REFERENCE_URL" ]; then
    log_error "REFERENCE_URL is required"
    exit 1
  fi

  log_info "Pushing images matching: $REFERENCE_URL"

  while IFS= read -r image; do
    push_image "$image"
  done < <(container_image_list "$REFERENCE_URL")
}
