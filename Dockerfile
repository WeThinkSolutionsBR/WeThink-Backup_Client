FROM alpine:3.9
MAINTAINER "WeThink Solutions <dev@wethinksolutions.com.br>

RUN mkdir /etc/bacula /var/lib/bacula

RUN apk -U upgrade && apk add \
    bash \
    bacula-client

ADD bacula-fd.conf /etc/bacula/bacula-fd.conf
ADD bacula-fd.conf /etc/bacula/bacula-fd.conf.orig

ADD run.sh /

RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]

EXPOSE 9102
