FROM centos
MAINTAINER d9magai

ENV TREEFROGFRAMEWORK_PREFIX /opt/treefrogframework
ENV TREEFROGFRAMEWORK_PREFIX_SRC_DIR $TREEFROGFRAMEWORK_PREFIX/src
ENV TREEFROGFRAMEWORK_VERSION 1.10.0
ENV TREEFROGFRAMEWORK_BASE_DIR $TREEFROGFRAMEWORK_PREFIX_SRC_DIR/treefrog-framework-$TREEFROGFRAMEWORK_VERSION
ENV TREEFROGFRAMEWORK_ARCHIVE_URL https://github.com/treefrogframework/treefrog-framework/archive/v$TREEFROGFRAMEWORK_VERSION.tar.gz

RUN yum update -y && yum install -y \
    gcc-c++ \
    make \
    gdb \
    qt-devel \
    qt-mysql \
    which \
    && yum clean all

RUN mkdir -p $TREEFROGFRAMEWORK_PREFIX_SRC_DIR \
    && curl -sL $TREEFROGFRAMEWORK_ARCHIVE_URL | tar xz -C $TREEFROGFRAMEWORK_PREFIX_SRC_DIR \
    && cd $TREEFROGFRAMEWORK_BASE_DIR \
    && ./configure --prefix=$TREEFROGFRAMEWORK_PREFIX \
    && cd $TREEFROGFRAMEWORK_BASE_DIR/src \
    && make \
    && make install \
    && cd $TREEFROGFRAMEWORK_BASE_DIR/tools \
    && make \
    && make install \
    && rm -rf $TREEFROGFRAMEWORK_PREFIX_SRC_DIR

RUN echo $TREEFROGFRAMEWORK_PREFIX/lib > /etc/ld.so.conf.d/treefrogframework.conf && ldconfig
ENV PATH $TREEFROGFRAMEWORK_PREFIX/bin:/usr/lib64/qt4/bin:$PATH

WORKDIR /srv/
CMD ["tspawn", "-h"]

