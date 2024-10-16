#!/bin/bash

service mariadb start

mariadb -e "DROP USER IF EXISTS ''@'localhost'"

mariadb -e "DROP DATABASE IF EXISTS test"

mariadb -e "CREATE DATABASE $MYSQL_DATABASE"

mariadb -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'"

mariadb -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* to '$MYSQL_USER'@'%'"

mariadb -e "ALTER USER '$MYSQL_ROOT'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';FLUSH PRIVILEGES"

