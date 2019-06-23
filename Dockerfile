FROM alpine:3.10.0
MAINTAINER d9magai

ENV MONGOCDRIVER_VERSION 1.14.0
ENV MONGOCDRIVER_ARCHIVE_URL https://github.com/mongodb/mongo-c-driver/archive/${MONGOCDRIVER_VERSION}.tar.gz
ENV TREEFROGFRAMEWORK_VERSION 1.24.0
ENV TREEFROGFRAMEWORK_ARCHIVE_URL https://github.com/treefrogframework/treefrog-framework/archive/v${TREEFROGFRAMEWORK_VERSION}.tar.gz
ENV PATH $PATH:/usr/lib/qt5/bin/
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib64

RUN apk add --update --no-cache --virtual=builddeps \
           curl                  \
           bash                  \
           cmake                 \
    && apk add --update --no-cache \
           g++                   \
           make                  \
           qt5-qtbase-dev        \
           qt5-qtdeclarative-dev \
           icu-dev               \
           cyrus-sasl-dev        \
           snappy-dev            \
    && curl -sL ${MONGOCDRIVER_ARCHIVE_URL} | tar -xvz -C / \
    && cd /mongo-c-driver-${MONGOCDRIVER_VERSION} \
    && mkdir cmake-build \
    && cd cmake-build \
    && cmake .. -L -DENABLE_AUTOMATIC_INIT_AND_CLEANUP=OFF -DENABLE_EXAMPLES=OFF -DENABLE_TESTS=OFF -DENABLE_UNINSTALL=OFF \
    && make -j $(nproc) \
    && make install \
    && curl -sL $TREEFROGFRAMEWORK_ARCHIVE_URL | tar -xvz -C / \
    && cd /treefrog-framework-${TREEFROGFRAMEWORK_VERSION} \
    && sed -i -e "1i LIBS = -L/usr/local/lib64 -lmongoc-1.0 -lbson-1.0" src/corelib.pro \
    && sed -i -e "1i INCLUDEPATH = /usr/local/include/libbson-1.0 /usr/local/include/libmongoc-1.0" src/corelib.pro \
    && ./configure --enable-shared-mongoc \
    && make -j $(nproc) -C src \
    && make -C src install \
    && make -j $(nproc) -C tools \
    && make -C tools install \
    && rm -rf /mongo-c-driver-${MONGOCDRIVER_VERSION} \
    && rm -rf /treefrog-framework-${TREEFROGFRAMEWORK_VERSION} \
    && apk del builddeps

EXPOSE 8800

