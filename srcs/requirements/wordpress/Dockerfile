FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install -y wget php php7.4-fpm php-mysql mariadb-client

RUN rm -rf /var/lib/apt/lists/*

# copy the wordpress configuration script to the root directory in the container
#COPY ./wp_conf.sh /

# define the entrypoint command to run when the container starts
#ENTRYPOINT ["./wp_conf.sh"]

#RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
#RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz 
#RUN rm wordpress-6.0-fr_FR.tar.gz
#RUN	chown -R root:root /var/www/wordpress