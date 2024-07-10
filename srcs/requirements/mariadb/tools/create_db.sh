#!/bin/bash

# Start MariaDB server in background
mysqld_safe &

# Wait for the MySQL server to be up and running
until mysqladmin ping &>/dev/null; do
    echo "Waiting for MariaDB to start..."
    sleep 1
done

# Check if database already exists
DB_EXISTS=$(mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "SHOW DATABASES LIKE '$MYSQL_DB_NAME'" | grep "$MYSQL_DB_NAME" > /dev/null; echo "$?")

if [ "$DB_EXISTS" -eq 1 ]; then
    mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DB_NAME\`" || { echo 'Failed to create database'; exit 1; }
    mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PW'" || { echo 'Failed to create user'; exit 1; }
    mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON \`$MYSQL_DB_NAME\`.* TO '$MYSQL_USER'@'%'" || { echo 'Failed to grant privileges'; exit 1; }
    mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;" || { echo 'Failed to flush privileges'; exit 1; }
fi

# Keep container running
tail -f /dev/null