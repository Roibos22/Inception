#!/bin/bash

# Start MySQL in the background
service mysql start

# Wait for MySQL to fully start (more robust check could be implemented)
sleep 10

# Database and user setup commands
mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DB_NAME\`" || { echo 'Failed to create database'; exit 1; }
mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PW'" || { echo 'Failed to create user'; exit 1; }
mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON \`$MYSQL_DB_NAME\`.* TO '$MYSQL_USER'@'localhost'" || { echo 'Failed to grant privileges'; exit 1; }
mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;" || { echo 'Failed to flush privileges'; exit 1; }

mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
exec mysqld_safe
