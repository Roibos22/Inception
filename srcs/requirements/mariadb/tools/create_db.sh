#!/bin/bash

# start mariadb server and wait for it to be up and running
service mariadb start
until mysqladmin ping &>/dev/null; do
    echo "Waiting for MariaDB to start..."
    sleep 1
done

# check if database already exists
DB_EXISTS=$(mysql -uroot -p"$MDB_PW" -e "SHOW DATABASES LIKE '$MDB_DB_NAME'" | grep "$MDB_DB_NAME" > /dev/null; echo "$?")

# create database if it does not exist
if [ "$DB_EXISTS" -eq 1 ]; then
    mysql -uroot -p"$MDB_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`$MDB_DB_NAME\`" || { echo 'Failed to create database'; exit 1; }
    mysql -uroot -p"$MDB_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MDB_USER'@'%' IDENTIFIED BY '$MDB_PW'" || { echo 'Failed to create user'; exit 1; }
    mysql -uroot -p"$MDB_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON \`$MDB_DB_NAME\`.* TO '$MDB_USER'@'%'" || { echo 'Failed to grant privileges'; exit 1; }
    mysql -uroot -p"$MDB_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;" || { echo 'Failed to flush privileges'; exit 1; }
fi

# shutdown and restart mariadb in background and with new config
mysqladmin -u root -p$MDB_ROOT_PASSWORD # shutdown
mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'

# create never ending process in foreground to keep container running
tail -f /dev/null