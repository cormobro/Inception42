#!/bin/bash

# Check if the database directory exists
rm -rf /var/lib/mysql/$MYSQL_DATABASE
if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    # If the directory exists, display a message indicating that the database already exists
    echo "Database already exists"
    #echo "Rebuilding new database"
    #rm -rf /var/lib/mysql/$MYSQL_DATABASE
else
    # If the directory does not exist, perform the following actions:

    # Upgrade MySQL (MariaDB) to the latest version
    mysql_upgrade --force

    # Install the MariaDB system tables and data files
    mysql_install_db

    # Start the MariaDB service
    service mariadb start
    cat $MYSQL_USER
    cat ${MYSQL_USER}
    # Run the script to secure the MariaDB installation, providing answers to prompts
    mysql_secure_installation << EOF

	n
	Y
	${MYSQL_ROOT_PASSWORD}
	${MYSQL_ROOT_PASSWORD}
	Y
	n
	Y
	Y
EOF

    # Access the MariaDB server and execute SQL commands to create database and user
    mariadb << EOF
    CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    FLUSH PRIVILEGES;
    exit
EOF

    # Stop the MariaDB service
    service mariadb stop
fi

# Execute mysqld with bind address set to accept connections from any IP address
exec mysqld --bind-address=0.0.0.0

