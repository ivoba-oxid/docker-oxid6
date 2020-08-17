FROM php:7.2-apache

MAINTAINER module@proudcommerce.com

ENV HOME /var/www
ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_CODENAME stretch

# timezone / date
RUN echo "Europe/Berlin" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

# install packages
RUN apt-get update \
  && echo 'deb http://packages.dotdeb.org stretch all' >> /etc/apt/sources.list \
  && echo 'deb-src http://packages.dotdeb.org stretch all' >> /etc/apt/sources.list \
  && apt-get install -y less vim wget unzip rsync git mysql-client gnupg \
  && wget https://www.dotdeb.org/dotdeb.gpg \
  && apt-key add dotdeb.gpg \
  && apt-get update \
  && apt-get install -y libfreetype6 libjpeg62-turbo libpng-dev libjpeg-dev libxml2-dev libwebp6 libxpm4 zsh \
  && docker-php-ext-configure gd --with-jpeg-dir=/usr/local/ \
  && docker-php-ext-install gd zip bcmath soap pdo_mysql\
  && pecl install xdebug-2.6.0beta1 \
  && docker-php-ext-enable xdebug \
  && apt-get clean \
  && apt-get autoremove -y

# composer stuff
#RUN php -r 'readfile("https://getcomposer.org/installer");' > composer-setup.php \
#  && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
#  && rm -f composer-setup.php \
#  && chown www-data:www-data /var/www

# prepare entrypoint.d pattern
RUN mkdir /entrypoint.d
COPY ./files/entrypoint.sh /entrypoint.sh
COPY ./entrypoint.d/* /entrypoint.d/
RUN chmod 777 /entrypoint.sh \
  && chmod 777 /entrypoint.d/*

# apache stuff
RUN /usr/sbin/a2enmod rewrite && /usr/sbin/a2enmod headers && /usr/sbin/a2enmod expires
COPY ./files/000-default.conf /etc/apache2/sites-available/000-default.conf

RUN usermod -u 1000 www-data -s /bin/zsh

#Install oh-my-zsh
ENV TERM=xterm
COPY ./files/zshrc.dist /var/www/.zshrc
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git /var/www/.oh-my-zsh

# install composer
COPY ./files/install_composer.sh /var/www/install_composer.sh
RUN sh /var/www/install_composer.sh

RUN chown -R www-data:www-data /var/www \
    && chmod -R g+rwx /var/www

# oxid stuff
COPY ./files/config.inc.php /var/www/config.inc.php

WORKDIR /var/www/html

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
