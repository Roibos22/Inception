#!/bin/bash

# CREATE WORDPRESS DIRECTORY
DIR="/home/lgrimmei/data/wordpress"
if [ -d "$DIR" ]; then
  echo "Directory $DIR already exists."
else
  echo "Directory $DIR does not exist. Creating it now..."
  mkdir -p "$DIR"
  echo "Directory $DIR created."
fi

# CREATE MARIADB DIRECTORY
DIR="/home/lgrimmei/data/mariadb"
if [ -d "$DIR" ]; then
  echo "Directory $DIR already exists."
else
  echo "Directory $DIR does not exist. Creating it now..."
  mkdir -p "$DIR"
  echo "Directory $DIR created."
fi



# Function to generate a random password
generate_password() {
  openssl rand -base64 16
}

if [ -d "secrets" ]; then
    echo "secrets folder already exists"
else
    mkdir secrets 
    generate_password > secrets/wp_user_password.txt
    generate_password > secrets/wp_root_password.txt
    generate_password > secrets/db_password.txt
    generate_password > secrets/db_root_password.txt
fi

# CREATE SSL DIRECTORY
DIR="/home/lgrimmei/data/ssl"
if [ -d "$DIR" ]; then
  echo "Directory $DIR already exists."
else
  echo "Directory $DIR does not exist. Creating it now..."
  mkdir -p "$DIR"
  openssl req -x509 -nodes -out secrets/inception.crt -keyout secrets/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=lgrimmei.42.fr/UID=lgrimmei"
  echo "Directory $DIR created."
fi

# CREATE ENV VARIABLES
if [ -f "srcs/.env" ]; then
    echo ".env already exists"
else
    echo "DOMAIN_NAME=lgrimmei.42.fr" >> srcs/.env
    echo "#mariadb" >> srcs/.env
    echo "MDB_USER=lgrimmei" >> srcs/.env
    echo "MDB_DB_NAME=database" >> srcs/.env
    echo "#wordpress" >> srcs/.env
    echo "WP_TITLE=lgrimmei" >> srcs/.env
    echo "WP_ADMIN_NAME=admin" >> srcs/.env
    echo "WP_ADMIN_EMAIL=admin@gmail.com" >> srcs/.env
    echo "WP_USER_NAME=user" >> srcs/.env
    echo "WP_USER_EMAIL=user@gmail.com" >> srcs/.env
    echo "WP_USER_ROLE=author" >> srcs/.env
    echo ".env created"
fi