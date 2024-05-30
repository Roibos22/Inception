#!/bin/bash

# Start the MySQL service
service mysql start

# Create the database (if it doesn't exist)
mysql -uroot -p  -e "CREATE DATABASE IF NOT EXISTS TESTDB"

# Create the user (if it doesn't exist)
mysql -uroot -p  -e "CREATE USER IF NOT EXISTS TESTUS@'localhost' IDENTIFIED BY 'TESTPW'"

# Note: Replace 'TESTPW' with your actual password

echo "Database and user created (if not already existing)."

mysql -e "GRANT ALL PRIVILEGES ON TESTDB.* TO TESTUS@'localhost' IDENTIFIED BY 'TESTPW';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'TESTPW';"
mysql -e "FLUSH PRIVILEGES;"
exec mysqld_safe