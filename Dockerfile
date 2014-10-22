FROM debian:wheezy
MAINTAINER Michael Barton, mail@michaelbarton.me.uk

ENV PACKAGES wget make g++ bc zlib1g-dev
ENV TAR http://minia.genouest.org/files/minia-1.6906.tar.gz
ENV DIR /tmp/minia

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends ${PACKAGES} && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir ${DIR}
RUN cd ${DIR} &&\
    wget ${TAR} -O - | tar xzf - --directory . --strip-components=1 &&\
    make k=128 && \
    mv minia /usr/local/bin

ADD Procfile /
ADD run /usr/local/bin/

ENTRYPOINT ["run"]
