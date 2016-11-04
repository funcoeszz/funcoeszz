FROM debian:jessie
MAINTAINER Aurelio Jargas <verde@aurelio.net>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y bc curl lynx

COPY . /app
WORKDIR /app

ENV LC_ALL C.UTF-8
ENV PATH   /app:$PATH
ENV ZZPATH /app/funcoeszz
ENV ZZDIR  /app/zz
ENV ZZTMPDIR /tmp

# Needed by functions --help (see core)
ENV PAGER  more

VOLUME /tmp

ENTRYPOINT ["bash", "funcoeszz"]
CMD ["--help"]
