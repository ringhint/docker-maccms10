FROM php:7.4-fpm-alpine3.13

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories

RUN install-php-extensions pdo_mysql zip redis opcache

RUN curl -sL https://github.com/aoaostar/toolbox/raw/main/docker/install.sh | bash docker-composer up -d
