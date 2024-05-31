# Use Debian Buster as the base image
FROM debian:buster

# Install NGINX 
RUN apt-get update && \
apt-get install -y nginx && \
rm -rf /var/lib/apt/lists/*

# Remove the default server definition
# RUN rm /etc/nginx/sites-enabled/default

# Copy custom NGINX config file
COPY srcs/requirements/nginx/conf/nginx.conf /etc/nginx/nginx.conf

# TSL SETUP
RUN apt-get update
RUN apt-get install openssl -y
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=lgrimmei.42.fr/UID=lgrimmei"

# Expose HTTP and HTTPS ports
EXPOSE 443

# Start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]