FROM debian:wheezy
MAINTAINER Michael Barton, mail@michaelbarton.me.uk

ENV PACKAGES wget
ENV TAR http://gatb-tools.gforge.inria.fr/versions/bin/minia-2.0.2-Linux.tar.gz
ENV DIR /tmp/minia

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends ${PACKAGES} && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir ${DIR}
RUN cd ${DIR} &&\
    wget ${TAR} -O - | tar xzf - --directory . --strip-components=1 &&\
    mv bin/minia /usr/local/bin

ADD Procfile /
ADD run /usr/local/bin/

ENTRYPOINT ["run"]
