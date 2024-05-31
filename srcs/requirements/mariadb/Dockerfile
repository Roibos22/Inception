FROM debian:buster

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y mariadb-server procps && \
    rm -rf /var/lib/apt/lists/*

COPY srcs/requirements/mariadb/tools/create_db.sh /usr/local/bin/create_db.sh
RUN chmod +x /usr/local/bin/create_db.sh

COPY srcs/requirements/mariadb/conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/create_db.sh"]