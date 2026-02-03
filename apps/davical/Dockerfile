FROM public.ecr.aws/docker/library/debian:12.13-slim@sha256:98f4b71de414932439ac6ac690d7060df1f27161073c5036a7553723881bffbe
ARG VERSION
USER 0:0
RUN apt update && apt install -y --no-install-recommends davical=${VERSION} php-ldap php-curl apache2 catatonit && apt clean && rm -rf /var/lib/apt/lists && rm -rf /var/cache /etc/systemd /lib/systemd && cd /etc/apache2/sites-enabled && ln -s ../sites-available/davical.conf ./davical.conf && cd /etc/apache2/mods-enabled && ln -s ../mods-available/headers.load ./headers.load && unlink /etc/apache2/sites-enabled/000-default.conf && echo 'Listen 8080' > /etc/apache2/ports.conf && echo 'ServerName ${APACHE_SERVERNAME}' >> /etc/apache2/apache2.conf

# www-data because it's already included and setup, change env vars if using other users
USER 33:33
# use /tmp dirs for all Apache runtime dirs to simplify tmpfs/emptyDir
WORKDIR /tmp/apache
WORKDIR /config
ENV APACHE_RUN_DIR=/tmp/apache
ENV APACHE_PID_FILE=/tmp/apache.pid
ENV APACHE_LOG_DIR=/tmp
ENV APACHE_RUN_USER=33
ENV APACHE_RUN_GROUP=33
# Set $APACHE_SERVERNAME yourself!
ENTRYPOINT ["/usr/bin/catatonit", "--", "/usr/sbin/apache2", "-D", "FOREGROUND"]
EXPOSE 8080/tcp
