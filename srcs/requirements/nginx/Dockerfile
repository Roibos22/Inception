# base image
FROM debian:bullseye

# update package manager
RUN apt-get update -y && apt-get upgrade -y

# install nginx and openssl
RUN apt-get install -y nginx openssl

# clean up cached package files
RUN rm -rf /var/lib/apt/lists/*

# copy custom NGINX config file into container
COPY srcs/requirements/nginx/conf/nginx.conf /etc/nginx/nginx.conf

# expose HTTP and HTTPS ports
EXPOSE 443

# start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]