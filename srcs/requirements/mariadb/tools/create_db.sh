#!/bin/bash

service mysql start

until [ -e /run/mysqld/mysqld.sock ]; do
    echo "Waiting for MySQL..."
    sleep 0.2
done

mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DB_NAME\`" || { echo 'Failed to create database'; exit 1; }
mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PW'" || { echo 'Failed to create user'; exit 1; }
mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON \`$MYSQL_DB_NAME\`.* TO '$MYSQL_USER'@'localhost'" || { echo 'Failed to grant privileges'; exit 1; }
mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;" || { echo 'Failed to flush privileges'; exit 1; }
