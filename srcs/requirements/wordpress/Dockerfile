# syntax=docker/dockerfile:1
FROM debian:bullseye

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install wget -y
RUN apt-get install php7.4 -y
RUN apt-get install php7.4-fpm -y
RUN apt-get install php7.4-mysql -y
RUN apt-get install php-gd -y
RUN apt-get install php-intl -y
RUN apt-get install php-mbstring -y
RUN apt-get install php-soap -y
RUN apt-get install php-xml -y
RUN apt-get install php-xmlrpc -y
RUN apt-get install php-zip -y
RUN apt-get install mariadb-client -y
RUN apt-get install sendmail -y

#wordpress
#RUN wget https://wordpress.org/latest.tar.gz -P /var/www/html
#RUN cd /var/www/html && tar -xzvf latest.tar.gz && rm latest.tar.gz
RUN mkdir /var/www/html/wordpress/ && chmod 777 -R /var/www/html/wordpress/
#chown -R root:root /var/www/html/wordpress/
#wp-cli (wordpress terminal)
#RUN chown -R root:root /var/www/html/wordpress/
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

RUN mkdir /run/php

COPY ./tools/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY ./tools/wordpress.sh /usr/local/bin/wordpress.sh
RUN chmod 777 -R /usr/local/bin/wordpress.sh

#WORKDIR /var/www/wordpress

#EXPOSE 9000

ENTRYPOINT ["bash", "/usr/local/bin/wordpress.sh"]
