FROM alpine
MAINTAINER d9magai

ENV TREEFROGFRAMEWORK_VERSION 1.22.0
ENV TREEFROGFRAMEWORK_ARCHIVE_URL https://github.com/treefrogframework/treefrog-framework/archive/v${TREEFROGFRAMEWORK_VERSION}.tar.gz
ENV PATH $PATH:/usr/lib/qt5/bin/

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
    && apk add --update --no-cache --virtual=builddeps \
           curl                  \
           bash                  \
    && apk add --update --no-cache \
           g++                   \
           make                  \
           qt5-qtbase-dev        \
           qt5-qtdeclarative-dev \
           mongo-c-driver-dev    \
    && curl -sL $TREEFROGFRAMEWORK_ARCHIVE_URL | tar -xvz \
    && cd /treefrog-framework-${TREEFROGFRAMEWORK_VERSION} \
    && ./configure --enable-shared-mongoc \
    && make -j $(nproc) -C src \
    && make -C src install \
    && make -j $(nproc) -C tools \
    && make -C tools install \
    && rm -rf /treefrog-framework-${TREEFROGFRAMEWORK_VERSION} \
    && apk del builddeps

EXPOSE 8800
WORKDIR /srv/
CMD ["tspawn", "-h"]
