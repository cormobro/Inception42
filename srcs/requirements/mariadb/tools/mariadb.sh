#!/bin/bash

if [ -d "/var/lib/mysql/$SQL_DATABASE" ]; then
    echo "Database already exists"
else
    mysql_upgrade --force
    mysql_install_db
    service mariadb start
    mysql_secure_installation << EOF
	n
	Y
	${SQL_ROOT_PASSWORD}
	${SQL_ROOT_PASSWORD}
	Y
	n
	Y
	Y
EOF
    mariadb << EOF
    CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
    FLUSH PRIVILEGES;
EOF
    service mariadb stop
fi
exec mysqld --bind-address=0.0.0.0

