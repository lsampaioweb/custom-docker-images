# Base image.
FROM alpine:3.20.0

LABEL authors="Luciano Sampaio"

# Arguments for CA certificate.
ARG CA_CERTIFICATE
ARG CA_CERTIFICATE_FILE="ca.crt"

# Install CA certificate.
RUN apk update && \
    apk upgrade && \
    apk add --no-cache ca-certificates && \
    update-ca-certificates && \
    echo "${CA_CERTIFICATE}" > /usr/local/share/ca-certificates/${CA_CERTIFICATE_FILE} && \
    update-ca-certificates

# Clean up.
RUN rm -rf /var/cache/apk/*

# Command to run.
CMD ["sh"]
