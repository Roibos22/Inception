#!/bin/bash

# Create a file containing all environment variables for debugging
env > /var/log/mariadb_env_vars.log

# Ensure the socket directory exists and has the correct permissions
mkdir -p /run/mysqld/
chown mysql:mysql /run/mysqld/
chmod 755 /run/mysqld/

# Start MariaDB server and wait for it to be up and running
service mariadb start
until mysqladmin ping &>/dev/null; do
    echo "Waiting for MariaDB to start..."
    sleep 1
done

# Check if database already exists
DB_EXISTS=$(mysql -uroot -p"$(<"$MDB_ROOT_PW")" -e "SHOW DATABASES LIKE '$MDB_DB_NAME'" | grep "$MDB_DB_NAME" > /dev/null; echo "$?")

# Create database if it does not exist
if [ "$DB_EXISTS" -eq 1 ]; then
    mysql -uroot -p"$(<"$MDB_ROOT_PW")" -e "CREATE DATABASE IF NOT EXISTS \`$MDB_DB_NAME\`" || { echo 'Failed to create database'; exit 1; }
    mysql -uroot -p"$(<"$MDB_ROOT_PW")" -e "CREATE USER IF NOT EXISTS '$MDB_USER'@'%' IDENTIFIED BY '$(<"$MDB_PW")'" || { echo 'Failed to create user'; exit 1; }
    mysql -uroot -p"$(<"$MDB_ROOT_PW")" -e "GRANT ALL PRIVILEGES ON \`$MDB_DB_NAME\`.* TO '$MDB_USER'@'%'" || { echo 'Failed to grant privileges'; exit 1; }
    mysql -uroot -p"$(<"$MDB_ROOT_PW")" -e "FLUSH PRIVILEGES;" || { echo 'Failed to flush privileges'; exit 1; }
fi

# Stop the MariaDB service started by the service command
service mariadb stop

# Start MariaDB in the foreground to keep the container running
exec mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'