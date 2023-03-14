ARG VARIANT=frpc

FROM golang:alpine AS building
# Recall arguments.
ARG VARIANT
# Install necessary packages.
RUN apk update && apk add git make
# Clone frp source code.
RUN git clone https://github.com/fatedier/frp.git /building
# Build frp from source.
WORKDIR /building
RUN make ${VARIANT}

FROM alpine:latest
# Recall arguments.
ARG VARIANT
# Install packages
RUN apk upgrade && apk add gettext
# Copy frp binary
COPY --from=building /building/bin/${VARIANT} /usr/bin/frp
# Copy scripts
ADD scripts /scripts
RUN chmod -R +x /scripts
# Setup entrypoint
ENTRYPOINT ["/scripts/entrypoint.sh"]