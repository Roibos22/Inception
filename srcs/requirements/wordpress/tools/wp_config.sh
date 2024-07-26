#!/bin/bash

### WAIT FOR MARIADB SERVER TO BE RUNNING
end_time=$((SECONDS + 10))
while (( SECONDS < end_time )); do
    if nc -zq 1 mariadb 3306; then
        echo "[### MARIADB IS UP AND RUNNING ###]"
        break
    else
        echo "[### WAITING FOR MARIADB TO START... ###]"
        sleep 1
    fi
done

if (( SECONDS >= end_time )); then
    echo "[### MARIADB IS NOT RESPONDING ###]"
fi


### INSTALL WORDPRESS
# install wordpress CLI (command line interface)
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# make the wp command globally executable
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp 

# go to wordpress directory and change its permission and owner so nginx can work with it
cd /var/www/wordpress
chmod -R 755 /var/www/wordpress/
chown -R www-data:www-data /var/www/wordpress

# download wordpress into /var/www/wordpress directory
wp core download --allow-root

# create wp-config.php file with details
wp core config --dbhost=mariadb:3306 --dbname="$MDB_DB_NAME" --dbuser="$MDB_USER" --dbpass="$(<"$MDB_PW")" --allow-root

# install wordpress with details
wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_NAME" --admin_password="$(<"$WP_ADMIN_PW")" --admin_email="$WP_ADMIN_EMAIL" --allow-root

# create new user
wp user create "$WP_USER_NAME" "$WP_USER_EMAIL" --user_pass="$(<"$WP_USER_PW")" --role="$WP_USER_ROLE" --allow-root

### CONFIGURE PHP

# change listen port from unix socket to 9000
sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf

# create a directory for php-fpm
mkdir -p /run/php

# start php-fpm service in the foreground to keep the container running
/usr/sbin/php-fpm7.4 -F


