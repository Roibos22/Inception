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

# CREATE ENV VARIABLES
if [ -f ".env" ]; then
    echo ".env already exists"
else
    echo "DOMAIN_NAME=lgrimmei.42.fr" >> srcs/.env
    echo "#mariadb" >> srcs/.env
    echo "MDB_USER=lgrimmei" >> srcs/.env
    echo "MDB_DB_NAME=database" >> srcs/.env
    echo "MDB_PW=ilove42" >> srcs/.env
    echo "MDB_ROOT_PASSWORD=ilove42" >> srcs/.env
    echo "#wordpress" >> srcs/.env
    echo "WP_TITLE=lgrimmei" >> srcs/.env
    echo "WP_ADMIN_NAME=admin" >> srcs/.env
    echo "WP_ADMIN_PW=ilove42" >> srcs/.env
    echo "WP_ADMIN_EMAIL=admin@gmail.com" >> srcs/.env
    echo "WP_USER_NAME=user" >> srcs/.env
    echo "WP_USER_PW=ilove42" >> srcs/.env
    echo "WP_USER_EMAIL=user@gmail.com" >> srcs/.env
    echo "WP_USER_ROLE=author" >> srcs/.env
    echo ".env created"
fi