#!/bin/bash

# Function to generate a random password
generate_password() {
  openssl rand -base64 8
}

# CREATE WORDPRESS DIRECTORY
DIR="/home/lgrimmei/data/wordpress"
if [ -d "$DIR" ]; then
  rm -fr "$DIR"
  echo -e "\e[33m✔\e[0m Directory $DIR removed."
fi
mkdir -p "$DIR"
echo -e "\e[32m✔\e[0m Directory $DIR created."

# CREATE MARIADB DIRECTORY
DIR="/home/lgrimmei/data/mariadb"
if [ -d "$DIR" ]; then
  rm -fr "$DIR"
  echo -e "\e[33m✔\e[0m Directory $DIR removed."
fi
mkdir -p "$DIR"
echo -e "\e[32m✔\e[0m Directory $DIR created."

# CREATE SECRETS DIRECTORY AND GENERATE PASSWORDS
DIR="/home/lgrimmei/Desktop/Inception/secrets"
if [ -d "$DIR" ]; then
  rm -fr "$DIR"
  echo -e "\e[33m✔\e[0m Directory $DIR removed."
fi
mkdir secrets
echo -e "\e[32m✔\e[0m Directory $DIR created."
generate_password > secrets/wp_user_password.txt
generate_password > secrets/wp_root_password.txt
generate_password > secrets/db_password.txt
generate_password > secrets/db_root_password.txt
echo -e "\e[32m✔\e[0m Secrets created."

# CREATE SSL DIRECTORY
DIR="/home/lgrimmei/data/ssl"
if [ -d "$DIR" ]; then
  rm -fr "$DIR"
  echo -e "\e[33m✔\e[0m Directory $DIR removed."
fi
mkdir -p "$DIR"
echo -e "\e[32m✔\e[0m Directory $DIR created."

# CREATE SSL CERTIFICATES
if [ ! -f "secrets/inception.crt" ] || [ ! -f "secrets/inception.key" ]; then
  openssl req -x509 -nodes -out secrets/inception.crt -keyout secrets/inception.key -subj "/C=DE/ST=IDF/L=BERLIN/O=42/OU=42/CN=lgrimmei.42.fr/UID=lgrimmei.42.fr" 2> /dev/null
  echo -e "\e[32m✔\e[0m SSL certificates created."
else
  echo -e "\e[33m✔\e[0m SSL certificates already exist."
fi

# CREATE ENV VARIABLES
if [ -f "srcs/.env" ]; then
  rm -fr srcs/.env
  echo -e "\e[33m✔\e[0m .env file removed."
fi
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