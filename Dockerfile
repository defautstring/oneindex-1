FROM php:fpm-alpine

COPY docker-entrypoint.sh php.ini default.conf /
RUN apk add --no-cache \
        git \
        bash \
        nginx \
        tzdata \
        openssh && \
    mkdir -p /run/nginx && \
    mv /default.conf /etc/nginx/conf.d && \
    mv /php.ini /usr/local/etc/php && \
    chmod +x /docker-entrypoint.sh && \
    git clone -b onemanager https://github.com/defautstring/OneManager-php.git /var/www/html/oneindex && \
    ssh-keygen -A && \
    chmod 666  /var/www/html/oneindex/config.php

EXPOSE 80
# Persistent config file and cache
VOLUME [ "/var/www/html", "/var/www/html" ]
ENTRYPOINT [ "/docker-entrypoint.sh" ]
