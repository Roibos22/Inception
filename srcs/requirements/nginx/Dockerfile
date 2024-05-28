# base image
FROM debian:buster

# Install build dependencies for Nginx
# -y
# build-essential 
# zlib1g-dev 
# libpcre3-dev 
# libssl-dev
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y build-essential zlib1g-dev libpcre3-dev libssl-dev

# Install wget
RUN apt-get update && apt-get install -y wget

# Install Nginx from source
# removed: useradd -r nginx && \
# removed: 
RUN groupadd -r nginx && \
    cd /usr/src && \
    wget https://nginx.org/download/nginx-1.23.2.tar.gz && \
    tar -xzf nginx-1.23.2.tar.gz && \
    cd nginx-1.23.2 && \
    ./configure --prefix=/etc/nginx --with-http_ssl_module && \
    make && \
    make install

# Install ca-certificates package for trusted certificates
RUN apt-get update && apt-get install -y ca-certificates

# Copy your Nginx configuration file (explained later)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose the port used by Nginx (default: 443 for HTTPS)
EXPOSE 443
EXPOSE 80