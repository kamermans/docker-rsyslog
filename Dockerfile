FROM ubuntu:14.04
MAINTAINER Steve Kamerman <stevekamerman@gmail.com>
LABEL Description="Rsyslog Container"

COPY resources/rsyslog.conf /etc/rsyslog.conf

# Automatically mount this on your other containers with --volumes-from
VOLUME /var/log

# Or you can send your log data here with TCP or UDP
EXPOSE 514
EXPOSE 514/udp

CMD ["/usr/sbin/rsyslogd", "-n"]
