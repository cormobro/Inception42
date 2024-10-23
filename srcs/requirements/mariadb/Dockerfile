FROM debian:bullseye

ARG SQL_DATABASE \
	SQL_ROOT \
	SQL_ROOT_PASSWORD \
	SQL_USER \
	SQL_PASSWORD

RUN apt-get -y update && apt-get -y upgrade && apt-get install -y mariadb-server

#RUN mkdir -p /run/mysqld
#RUN chown -R mysql:mysql /run/mysqld

#RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && chmod 777 /var/run/mysqld

COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/mariadb.sh /usr/local/bin/mariadb.sh
RUN chmod 777 -R /usr/local/bin/mariadb.sh
RUN /usr/local/bin/mariadb.sh



#EXPOSE 3306

#ENTRYPOINT ["tail", "-f", "/dev/null"]
#ENTRYPOINT ["/usr/local/bin/mariadb.sh"]
ENTRYPOINT ["mysqld_safe"]
