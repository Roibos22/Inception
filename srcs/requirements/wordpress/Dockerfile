FROM alpine:3.18

# Install dependencies needed to build WordPress
RUN apk add --no-cache wget curl unzip php7.4-fpm php7.4-mysqli

# Download WordPress source code
RUN wget https://wordpress.org/latest.tar.gz

# Extract the downloaded archive
RUN tar -xzf latest.tar.gz

# Move to the WordPress directory
WORKDIR wordpress

# Copy any additional files you need (if applicable)
COPY . .

# Create a user for WordPress process (optional)
RUN adduser -D wordpress

# Set ownership of files (optional, if using a user)
RUN chown -R wordpress:wordpress .

# Expose the port used by php-fpm (usually 9000)
EXPOSE 9000

# Define the entrypoint to start php-fpm
ENTRYPOINT ["php-fpm"]