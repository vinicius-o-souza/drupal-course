FROM php:7.3-apache  

RUN apt-get update && apt-get install -y \  
    mysql-client \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng12-dev \
    php-pear \
    curl \
    zlib1g-dev \
    libncurses5-dev

RUN docker-php-ext-install mysqli  
RUN docker-php-ext-install pdo pdo_mysql  
RUN docker-php-ext-install mbstring  
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/  
RUN docker-php-ext-install gd

RUN curl -L http://pecl.php.net/get/memcache-3.0.8.tgz >> /usr/src/php/ext/memcache.tgz && \  
tar -xf /usr/src/php/ext/memcache.tgz -C /usr/src/php/ext/ && \  
rm /usr/src/php/ext/memcache.tgz && \  
docker-php-ext-install memcache-3.0.8

RUN curl -L https://pecl.php.net/get/uploadprogress-1.0.3.1.tgz >> /usr/src/php/ext/uploadprogress.tgz && \  
tar -xf /usr/src/php/ext/uploadprogress.tgz -C /usr/src/php/ext/ && \  
rm /usr/src/php/ext/uploadprogress.tgz && \  
docker-php-ext-install uploadprogress-1.0.3.1

RUN mkdir /usr/bin/composer  
COPY composer.phar /usr/bin/composer/    

RUN a2enmod rewrite

RUN service apache2 restart

EXPOSE 80  