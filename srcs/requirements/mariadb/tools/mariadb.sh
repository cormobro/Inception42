#!/bin/bash

#if [ -d "/var/lib/mysql/$SQL_DATABASE" ]; then
#    echo "Database already exists"
#else
#	mysql_upgrade --force
#	mysql_install_db
#	service mariadb start
#	mysql_secure_installation << EOF
#	n
#	Y
#	${SQL_ROOT_PASSWORD}
#	${SQL_ROOT_PASSWORD}
#	Y
#	n
#	Y
#	Y
#EOF

service mariadb start

mariadb -e "DROP USER IF EXISTS ''@'localhost'"

mariadb -e "DROP DATABASE IF EXISTS $SQL_DATABASE"

mariadb -e "CREATE DATABASE $SQL_DATABASE"

mariadb -e "CREATE USER '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD'"

mariadb -e "GRANT ALL PRIVILEGES ON $SQL_DATABASE.* TO '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD'"

mariadb -e "ALTER USER '$SQL_ROOT'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';FLUSH PRIVILEGES"

#exit
#EOF

#service mariadb stop

#echo MABITE

#mysqld_safe
#exec mysqld --bind-address=0.0.0.0
