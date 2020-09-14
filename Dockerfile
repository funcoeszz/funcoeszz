FROM debian:8-slim
LABEL MAINTAINER Aurelio Jargas <verde@aurelio.net>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y bc curl lynx links unzip && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*
# RUN apk update && \
#     apk add --no-cache bash sed fmt bc curl lynx links unzip && \
#     rm -rf /var/cache/apk/*

# Using dumb-init to catch user signals https://github.com/funcoeszz/funcoeszz/issues/374
RUN curl -fsSL https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 > /dumb-init && \
    chmod +x /dumb-init

ENV PATH=/app:$PATH \
    ZZPATH=/app/funcoeszz \
    ZZDIR=/app/zz \
    ZZTMPDIR=/tmp \
    LC_ALL=C.UTF-8 \
    TERM=xterm \
    PAGER=more

# User may want to preserve the functions cache
VOLUME /tmp

COPY . /app/
WORKDIR /app

ENTRYPOINT ["/dumb-init", "--", "bash", "funcoeszz"]
CMD ["--help"]
