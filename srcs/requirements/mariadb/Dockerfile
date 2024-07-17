# base image
FROM debian:bullseye

# update package manager
RUN apt-get update -y && apt-get upgrade -y

# install mariadb for database and procps for process control 
RUN apt-get install -y mariadb-server procps




# clean up cached package files
RUN rm -rf /var/lib/apt/lists/*

# copy database creation script and config file from host into container
COPY srcs/requirements/mariadb/tools/create_db.sh /usr/local/bin/create_db.sh
COPY srcs/requirements/mariadb/conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# change executable rights of database creation script
RUN chmod +x /usr/local/bin/create_db.sh

# expose port 3306 for communication
EXPOSE 3306

# define database creation script to run when container starts
ENTRYPOINT ["/usr/local/bin/create_db.sh"]