#!/bin/bash

# Ensure the socket directory exists and has the correct permissions
mkdir -p /run/mysqld/
chown mysql:mysql /run/mysqld/
chmod 755 /run/mysqld/

# Start MariaDB server directly
mysqld_safe --datadir='/var/lib/mysql' &
until mysqladmin ping -uroot -p"$(cat "$MDB_ROOT_PW")" --silent; do
    echo "Waiting for MariaDB to start..."
    sleep 1
done

# Check if database already exists
DB_EXISTS=$(mysql -uroot -p"$(cat "$MDB_ROOT_PW")" -e "SHOW DATABASES LIKE '$MDB_DB_NAME'" | grep "$MDB_DB_NAME" > /dev/null; echo "$?")

# Create database if it does not exist
if [ "$DB_EXISTS" -eq 1 ]; then
    echo "Database does not exist. Creating database and user..." >> /var/log/mariadb_env_vars.log
    mysql -uroot -p"$(cat "$MDB_ROOT_PW")" -e "CREATE DATABASE IF NOT EXISTS \`$MDB_DB_NAME\`" || { echo 'Failed to create database' >> /var/log/mariadb_env_vars.log; exit 1; }
    mysql -uroot -p"$(cat "$MDB_ROOT_PW")" -e "CREATE USER IF NOT EXISTS '$MDB_USER'@'%' IDENTIFIED BY '$(cat "$MDB_PW")'" || { echo 'Failed to create user' >> /var/log/mariadb_env_vars.log; exit 1; }
    mysql -uroot -p"$(cat "$MDB_ROOT_PW")" -e "GRANT ALL PRIVILEGES ON \`$MDB_DB_NAME\`.* TO '$MDB_USER'@'%'" || { echo 'Failed to grant privileges' >> /var/log/mariadb_env_vars.log; exit 1; }
    mysql -uroot -p"$(cat "$MDB_ROOT_PW")" -e "FLUSH PRIVILEGES;" || { echo 'Failed to flush privileges' >> /var/log/mariadb_env_vars.log; exit 1; }
    echo "Database and user created successfully." >> /var/log/mariadb_env_vars.log
else
    echo "Database already exists. Skipping creation." >> /var/log/mariadb_env_vars.log
fi

# Stop the MariaDB service started by the service command
mysqladmin shutdown -uroot -p"$(cat "$MDB_ROOT_PW")"

# Start MariaDB in the foreground to keep the container running
exec mysqld_safe --datadir='/var/lib/mysql'