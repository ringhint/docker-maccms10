#
# Dockerfile for MACCMS
#

FROM php:apache-stretch

ADD sources.list etc/apt/

RUN apt-get update && apt-get install -y \
        unzip \
        libzip-dev \
        libfreetype6-dev \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install fileinfo \
    && docker-php-ext-install zip \
    && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/freetype2 \
    && docker-php-ext-install -j$(nproc) gd

ENV CMS_WWW_ROOT var/www/html

ADD maccms.zip tmp/maccms.zip

RUN unzip tmp/maccms.zip \
    && mv maccms/* ${CMS_WWW_ROOT} \
    && cd ${CMS_WWW_ROOT} \
    && mv admin.php cmsadmin.php \
    && chmod a+rw -R application runtime upload static addons \
    && rm -rf var/lib/apt/lists/*

EXPOSE 80
