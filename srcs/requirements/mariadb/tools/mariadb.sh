#!/bin/bash

# Check if the database directory exists
#rm -rf /var/lib/mysql/$SQL_DATABASE
if [ -d "/var/lib/mysql/$SQL_DATABASE" ]; then
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
    # Run the script to secure the MariaDB installation, providing answers to prompts
echo --------------------------------
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
echo ----------------------------------
    # Access the MariaDB server and execute SQL commands to create database and user
    #mariadb << EOF
    #CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}`;
    #CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
    #GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
    #FLUSH PRIVILEGES;
#EOF

    mariadb << EOF
    CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
    FLUSH PRIVILEGES;
EOF


    # Stop the MariaDB service
    service mariadb stop
fi

# Execute mysqld with bind address set to accept connections from any IP address
exec mysqld --bind-address=0.0.0.0

