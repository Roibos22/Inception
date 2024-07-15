# base image
FROM debian:bullseye

# update package manager
RUN apt-get update -y && apt-get upgrade -y

# install nginx and openssl
RUN apt-get install -y nginx openssl

# clean up cached package files
RUN rm -rf /var/lib/apt/lists/*

# copy custom NGINX config file
COPY srcs/requirements/nginx/conf/nginx.conf /etc/nginx/nginx.conf

# generate ssl certificate and save it in ssl directory
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=lgrimmei.42.fr/UID=lgrimmei"

# expose HTTP and HTTPS ports
EXPOSE 443

# start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]