FROM jprjr/arch:latest
MAINTAINER John Regan <john@jrjrtech.com>

RUN pacman -Syy --quiet >/dev/null 2>/dev/null && \
    pacman -S --noconfirm --quiet mariadb-clients \
      dbmail >/dev/null 2>/dev/null

ADD s6-1.1.3.2-musl-static.tar /


RUN mkdir -p /opt/dbmail && \
    mkdir -p /etc/s6/.s6-svscan && \
    mkdir -p /etc/s6/dbmail-imapd && \
    mkdir -p /etc/s6/dbmail-httpd && \
    mkdir -p /etc/s6/dbmail-lmtpd && \
    ln -s /bin/true /etc/s6/dbmail-imapd/finish && \
    ln -s /bin/true /etc/s6/dbmail-httpd/finish && \
    ln -s /bin/true /etc/s6/dbmail-lmtpd/finish && \
    touch /etc/s6/dbmail-httpd/down && \
    ln -s /bin/true /etc/s6/.s6-svscan/finish

ADD dbmail-imapd.run /etc/s6/dbmail-imapd/run
ADD dbmail-imapd.setup /etc/s6/dbmail-imapd/setup
ADD dbmail-httpd.run /etc/s6/dbmail-httpd/run
ADD dbmail-httpd.setup /etc/s6/dbmail-httpd/setup
ADD dbmail-lmtpd.run /etc/s6/dbmail-lmtpd/run
ADD dbmail-lmtpd.setup /etc/s6/dbmail-lmtpd/setup
ADD conf/dbmail.conf.mysql /opt/dbmail/dbmail.conf.mysql
ADD conf/create_tables.mysql /opt/dbmail/create_tables.mysql

EXPOSE 24
EXPOSE 143
EXPOSE 993
EXPOSE 41380
#EXPOSE 12345
#EXPOSE 10026

ENTRYPOINT ["/usr/bin/s6-svscan","/etc/s6"]
