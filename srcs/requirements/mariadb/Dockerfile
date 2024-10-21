FROM debian:bullseye

RUN apt-get -y update && apt-get -y upgrade && apt-get install -y mariadb-server

RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld

RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && chmod 777 /var/run/mysqld

COPY ./tools/mariadb.sh /usr/local/bin/mariadb.sh
RUN chmod 777 -R /usr/local/bin/mariadb.sh

EXPOSE 3306

ENTRYPOINT ["./usr/local/bin/mariadb.sh"]
# ENTRYPOINT ["tail", "-f", "/dev/null"]
