# Use Debian Buster as the base image
FROM debian:buster

# Install NGINX 
RUN apt-get update && \
apt-get install -y nginx && \
rm -rf /var/lib/apt/lists/*

# Remove the default server definition
# RUN rm /etc/nginx/sites-enabled/default

# Copy custom NGINX config file
COPY nginx.conf /etc/nginx/nginx.conf

# Copy SSL certificate and key
# COPY server.crt /etc/ssl/certs/server.crt
# COPY server.key /etc/ssl/private/server.key

# Expose HTTP and HTTPS ports
EXPOSE 80 
#443

# Start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]