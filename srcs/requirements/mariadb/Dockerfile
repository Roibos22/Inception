FROM debian:buster

RUN apt update -y
RUN apt upgrade -y
RUN apt-get install mariadb-server -y

COPY tools/create_db.sh /usr/local/bin/create_db.sh
RUN chmod +x /usr/local/bin/create_db.sh

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/create_db.sh"]