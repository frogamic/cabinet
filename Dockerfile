FROM alpine:latest

# Use S6 for supervision
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.8.0/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

RUN ["/sbin/apk", "add", "--no-cache", "samba-server", "samba-common-tools", "openssl"]

EXPOSE 137/udp 138/udp 139/tcp 445/tcp
VOLUME ["/share", "/config"]
ENV AUTO_SHARE="TRUE"

COPY autoshare.sh /etc/cont-init.d/00-autoshare
COPY services/smbd.sh /etc/services.d/smbd/run
COPY services/nmbd.sh /etc/services.d/nmbd/run

ENTRYPOINT ["/init"]
