FROM alpine:latest
MAINTAINER Balazs Szabo <balazs.szabo@gmail.com>

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
	apk update \
    && apk add shadow bash nginx ca-certificates \
    && apk --update add \
        php7 \
        php7-dom \
        php7-ctype \
        php7-curl \
        php7-fpm \
        php7-gd \
        php7-intl \
        php7-json \
        php7-mbstring \
        php7-mcrypt \
        php7-mysqlnd \
        php7-opcache \
        php7-pdo \
        php7-pdo_mysql \
        php7-pdo_sqlite \
        php7-exif \
        php7-mongodb \
        php7-posix \
        php7-session \
        php7-xml \
        php7-iconv \
        php7-phar \
        php7-openssl \
        php7-zip \
        php7-soap \
        php7-zlib \
        php7-ftp \
        php7-bz2 \
    && rm -rf /var/cache/apk/*

ENV PHPREDIS_VERSION php7    
RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
    && docker-php-ext-install redis
    
# fix php-fpm "Error relocating /usr/bin/php-fpm: __flt_rounds: symbol not found" bug
RUN apk add -u musl
RUN rm -rf /var/cache/apk/*

ADD files/nginx.conf /etc/nginx/
ADD files/php-fpm.conf /etc/php7/
ADD files/run.sh /
RUN chmod +x /run.sh

RUN usermod -u 1000 nginx
RUN apk del shadow

EXPOSE 80
VOLUME ["/DATA","/DATA/htdocs"]

CMD ["/run.sh"]
