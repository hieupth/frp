ARG VARIANT=frpc

FROM golang:alpine AS BUILD
# Recall arguments.
ARG VARIANT
# Install necessary packages.
RUN apk update && apk add --no-cache git make
# Clone frp source code.
RUN git clone https://github.com/fatedier/frp.git /build
# Build frp from source.
WORKDIR /build
RUN make ${VARIANT}

FROM python:3-alpine
# Recall arguments.
ARG VARIANT
# Install packages.
RUN apk update && \
    apk upgrade
# Copy compiled bin.
COPY --from=BUILD /build/bin/${VARIANT} /usr/bin/frp
# Copy necessary scripts.
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY frps.ini /etc/frp/frp.ini
RUN chmod +x /usr/local/bin/entrypoint.sh
# Setup entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]