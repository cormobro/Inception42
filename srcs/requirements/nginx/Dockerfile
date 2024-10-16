# syntax=docker/dockerfile:1
FROM debian:bullseye

RUN apt-get -y update && apt-get -y upgrade
RUN apt install nginx -y
RUN apt install vim -y
RUN apt install curl -y
RUN apt install openssl -y
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=BE/ST=BC/L=Brussels/O=19/OU=19/CN=febonaer.42.fr/UID=febonaer"
RUN mkdir -p /var/run/nginx
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]
