FROM debian:wheezy
MAINTAINER Michael Barton, mail@michaelbarton.me.uk

ENV PACKAGES wget
ENV TAR http://gatb-tools.gforge.inria.fr/versions/bin/minia-0.1.1-Linux.tar.gz
ENV DIR /tmp/minia

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends ${PACKAGES} && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir ${DIR}
RUN cd ${DIR} &&\
    wget ${TAR} -O - | tar xzf - --directory . --strip-components=1 &&\
    mv bin/minia /usr/local/bin

RUN wget http://mirrors.kernel.org/ubuntu/pool/main/e/eglibc/libc6_2.15-0ubuntu10.9_amd64.deb && dpkg -x libc6_2.15-0ubuntu10.9_amd64.deb /root 

ENV LD_LIBRARY_PATH /root/lib/x86_64-linux-gnu/

ADD Procfile /
ADD run /usr/local/bin/

ENTRYPOINT ["run"]
