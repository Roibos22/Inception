#!/bin/bash

# Function to generate a random password
generate_password() {
  openssl rand -base64 16
}

# CREATE WORDPRESS DIRECTORY
DIR="/home/lgrimmei/data/wordpress"
if [ -d "$DIR" ]; then
  echo -e "\e[33m✔\e[0m Directory $DIR already exists."
else
  mkdir -p "$DIR"
  echo -e "\e[32m✔\e[0m Directory $DIR created."
fi

# CREATE MARIADB DIRECTORY
DIR="/home/lgrimmei/data/mariadb"
if [ -d "$DIR" ]; then
  echo -e "\e[33m✔\e[0m Directory $DIR already exists."
else
  mkdir -p "$DIR"
  echo -e "\e[32m✔\e[0m Directory $DIR created."
fi

# CREATE SECRETS DIRECTORY AND GENERATE PASSWORDS
if [ -d "secrets" ]; then
  echo -e "\e[33m✔\e[0m Secrets folder already exists."
else
  mkdir secrets
  generate_password > secrets/wp_user_password.txt
  generate_password > secrets/wp_root_password.txt
  generate_password > secrets/db_password.txt
  generate_password > secrets/db_root_password.txt
  echo -e "\e[32m✔\e[0m Secrets folder created and passwords generated."
fi

# CREATE SSL DIRECTORY
DIR="/home/lgrimmei/data/ssl"
if [ -d "$DIR" ]; then
  echo -e "\e[33m✔\e[0m Directory $DIR already exists."
else
  mkdir -p "$DIR"
  echo -e "\e[32m✔\e[0m Directory $DIR created."
fi

# CREATE SSL CERTIFICATES
if [ ! -f "secrets/inception.crt" ] || [ ! -f "secrets/inception.key" ]; then
  openssl req -x509 -nodes -out secrets/inception.crt -keyout secrets/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=lgrimmei.42.fr/UID=lgrimmei" 2> /dev/null
  echo -e "\e[32m✔\e[0m SSL certificates created."
else
  echo -e "\e[33m✔\e[0m SSL certificates already exist."
fi

# CREATE ENV VARIABLES
if [ -f "srcs/.env" ]; then
  echo -e "\e[33m✔\e[0m .env file already exists."
else
  echo "DOMAIN_NAME=lgrimmei.42.fr" >> srcs/.env
  echo "#mariadb" >> srcs/.env
  echo "MDB_USER=lgrimmei" >> srcs/.env
  echo "MDB_DB_NAME=database" >> srcs/.env
  echo "#wordpress" >> srcs/.env
  echo "WP_TITLE=inception" >> srcs/.env
  echo "WP_ADMIN_NAME=lgrimmei" >> srcs/.env
  echo "WP_ADMIN_EMAIL=lgrimmei@gmail.com" >> srcs/.env
  echo "WP_USER_NAME=user" >> srcs/.env
  echo "WP_USER_EMAIL=user@gmail.com" >> srcs/.env
  echo "WP_USER_ROLE=author" >> srcs/.env
  echo -e "\e[32m✔\e[0m .env file created."
fi