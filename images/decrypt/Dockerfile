ARG VARIANT=frpc

FROM hieupth/${VARIANT}
# Install packages.
RUN apk update && \
    apk upgrade && \
    apk add --update git && \
    apk add --no-cache --virtual .build-deps linux-headers gcc musl-dev && \
    pip install ansible-vault && \
    apk del .build-deps
# Overwrite entrypoint.
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]