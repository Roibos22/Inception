# base image
FROM debian:bullseye

# update package manager
RUN apt-get update -y && apt-get upgrade -y

# install packages
RUN apt-get install -y wget php php7.4-fpm php-mysql mariadb-client

# clean up cached package files
RUN rm -rf /var/lib/apt/lists/*

# copy wordpress config script into container
COPY srcs/requirements/wordpress/tools/wp_config.sh /usr/local/bin/wp_config.sh

# change executable rights of database creation script
RUN chmod +x /usr/local/bin/wp_config.sh

# define wordpress config script to run when container starts
ENTRYPOINT ["/usr/local/bin/wp_config.sh"]
