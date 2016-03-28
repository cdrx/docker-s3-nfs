FROM phusion/baseimage

ENV DEBIAN_FRONTEND=noninteractive

RUN set -x \
    && apt-add-repository -y ppa:nikratio/s3ql \
    && apt-get update \
    && apt-get install -y s3ql ca-certificates python-swiftclient nfs-kernel-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD nfs-server.sh /etc/my_init.d/nfs-server.sh

ADD s3ql.run /etc/service/s3ql/run
ADD s3ql.finish /etc/service/s3ql/finish

RUN mkdir /storage

EXPOSE 111/udp 111/tcp 2049/udp 2049/tcp 32765/udp 32765/tcp 32766/udp 32766/tcp 32767/udp 32767/tcp 32768/udp 32768/tcp

CMD ["/sbin/my_init"]
