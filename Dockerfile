ARG VARIANT=frps
ARG BASE=alpine:3

FROM golang:alpine AS BUILD
# Recall arguments.
ARG VARIANT
# Install necessary packages.
RUN apk update && apk add --no-cache git make
# Clone frp source code.
RUN git clone https://github.com/fatedier/frp.git /build
# Build frp from source.
WORKDIR /build
RUN git checkout master && make ${VARIANT}

FROM ${BASE}
# Recall arguments.
ARG VARIANT
# Install packages.
RUN apk update && apk upgrade && apk add --no-cache curl tini
# Copy compiled bin.
COPY --from=BUILD /build/bin/${VARIANT} /usr/bin/frp
COPY  ./entrypoint.sh /entrypoint.sh
# Set tini.
ENTRYPOINT ["tini", "-g", "--"]
# Default CMD
CMD [ "/bin/sh", "/entrypoint.sh" ]