# Use the specified version of Alpine
FROM alpine:3.18
FROM mariadb:latest

# Set environment variables for database credentials (replace with your desired values)
ENV MYSQL_ROOT_PASSWORD=your_strong_password
ENV MYSQL_DATABASE=wordpress

# Expose the port used by MariaDB (usually 3306)
EXPOSE 3306

# Command to start the MariaDB service
CMD ["mysqld"]

