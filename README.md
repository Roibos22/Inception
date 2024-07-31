
# INCEPTION

### Table Of Contents

- [Installation Guide](#installation-guide)
- [What is NGINX](#what-is-nginx)
- ### What is NGINX
- 


Welcome to my repository for the Inception project at 42 Berlin! This project involves setting up a multi-container Docker application, which includes configuring various services and ensuring they work seamlessly together. 
I wrote this guide primarily for my own learning, as this topic was entirely new to me and by documenting and repeating these concepts, I’ve gained a good understanding and can recommend doing the same.
If you spot any mistakes or have suggestions, please don't hesitate to reach out!

![Screenshot from 2024-07-27 21-54-32](https://github.com/user-attachments/assets/862541a5-7fd2-403d-9c64-8899c24bdf4b)

## Installation Guide

### Prerequisites
- Docker installed on your system
- Docker Compose installed on your system


### Installation
1. Clone the Repository 

```
git clone https://github.com/yourusername/inception-project.git Inception
```   

1. Move into Repository

```
cd Inception
``` 

1. Initialize the Environment

```
make init
```

1. Build and Run the Containers

```
make run
```

1. Access the Services

**nginx:**

Open your browser and go to `https://lgrimmei.42.fr`

**WordPress:**

Open your browser and go to `https://lgrimmei.42.fr/wp-login.php` . Login with the data from the .env file and the secrets folder.

**MariaDB**

Move into mariadb container with the command

```
docker exec -it mariadb bash
``` 

Access the database with the command

```
mysql
```

##

![docker-logo-horizontal](https://github.com/user-attachments/assets/b63df024-59e4-4ec2-9ed8-d61eb60e42e9)

### **What is Docker?**

Docker itself is a platform for developing, deploying, and running applications using containers. Think of it as a toolset for packaging and managing your applications. A Docker container includes everything one needs to run an application, for example the code, system tools and settings. The Containers are created from Docker Images, which basically are templates with Instructions to create a Docker Container. 

In short, a Dockerfile defines what goes into an image, images are used to create containers, containers are the actual running applications, Docker Compose helps manage those applications if they have multiple parts, and Docker commands are the tools you use to put it all together.

**The benefits of Docker compared to VMs:**

- As Docker containers share the kernel with the host system, they are much more lightweight than VMs, which need their own OS installed.
- Docker Containers regularly have faster startup times than Virtual Machines
- Docker Containers use fewer resources, which makes them more efficient.
- Docker Containers can run n any system that supports Docker and therefore are very portable.

### **What is a Docker File?**

This is a text file with instructions that tell Docker how to build a specific image. It defines things like the operating system, libraries, and application code needed for your application to run.

**Common Instructions for Dockerfiles:**

- **FROM**: defines the base image for your container. This is the foundation upon which you build your application.
- **WORKDIR**: Sets the working directory for subsequent instructions like `RUN`, `COPY`, and `ADD`. This helps organize your container's file system and keeps things tidy.
- **RUN**: Executes commands within the container during the build process. This can be used to install dependencies, compile code, or perform any other setup tasks needed for your application to run.
- **COPY**: Copies files or directories from the host machine (where you're building the image) to the container's file system. This is typically used to copy your application code, configuration files, or any other resources your application needs.
- **ADD**: Similar to `COPY`, but it can also unpack compressed archives (like `.tar.gz` or `.zip`) during the copy process. This is useful if your application code or dependencies are stored in compressed formats.
- **CMD**: Specifies the default command that will be executed when the container starts. This essentially defines what your application will do inside the container.
- **ENTRYPOINT**: Similar to `CMD`, but it defines the executable process that runs when the container starts. You can use `ENTRYPOINT` with arguments passed via the `docker run` command.
- **EXPOSE**: Exposes a port within the container, allowing external connections to reach your application running inside.
- **ENV**: Sets environment variables within the container that your application can access.

### **What is a Docker Image?**

An image is a blueprint for a container. It's a read-only template that contains all the ingredients your application needs to run. You can think of it as a recipe for building a container.

### **What is a Docker Container?**

A container is a running instance of an image. It's like a lightweight virtual machine that packages your application and all its dependencies together. Containers are isolated from each other and share the underlying host operating system kernel, making them efficient and portable.

### What is Docker Network?

Docker Network is a feature that allows containers to communicate with each other, either on the same host or across different hosts. By default, Docker creates three types of networks:

- **Bridge**: The default network driver. Containers connected to the same bridge network can communicate with each other.
- **Host**: Removes network isolation between the container and the Docker host, and uses the host’s networking directly.
- **None**: Disables networking for the container.

You can also define your own networks using for example a .yml file what allows to create more complex networks. 

### What is Docker Compose?

This is a tool for defining and running multi-container applications. It lets you describe all the services (containers) your application needs in a single file (.yml) and easily start them up together with a single command. Imagine it as a way to manage a whole recipe book (with multiple recipes) for your application.

**Advantage of using Docker Compose for networking:**

When starting up multiple Containers without Docker compose, we will need to manually set up the networking between them in order to let the Containers communicate with each other, what can be quite cumbersome. You need to manually create the network, then run each container, while specifying the network, ports, volumes and env variables, what is quite error-prone. Using a docker compose file lets you define all of this in a single file, what leads to easier management of the Containers.

### **Docker Commands**

```bash
# GENERAL
docker ps -a                               # List all containers, including stopped ones
docker rm $(docker ps -a -q)               # Delete all containers (stopped and running)
docker stop $(docker ps -q)                # Stop all running containers
docker restart "container_id"              # Restart a specific container
docker logs "container_id"                 # Fetch the logs of a container
docker exec -it "container_id" bash        # Access a running container with an interactive terminal
docker system prune                        # Remove all unused containers, networks, images (both dangling and unreferenced), and optionally, volumes
    --all                                  # Remove all unused images, not just dangling ones
    --force                                # Do not prompt for confirmation before pruning
  
# IMAGES
docker images                              # List all Docker images
docker build -t "image_name" .             # Build an image from a Dockerfile in the current directory
docker image rm -f "image_name"            # Forcefully delete the image, if the image is running you need to stop it first

# CONTAINERS
docker run "image_name"                    # Run a Docker container from the specified image
    -d                                     # Run container in the background (detached mode)                        
    -p 700:80                              # Map port 7000 on the host to port 80 in the container
    -P                                     # Publish all exposed ports to random ports on the host
    -it                                    # Run container in interactive mode with a terminal session
docker inspect "container_id"              # Display detailed information about a container
docker stop "container_id"                 # Stop a running container

# VOLUMES
docker volume ls                           # List all Docker volumes
docker volume rm "volume_name"             # Remove a specific Docker volume
docker volume prune                        # Remove all unused volumes

# NETWORKS
docker network ls                          # List all Docker networks
docker network create "network_name"       # Create a new Docker network
docker network rm "network_name"           # Remove a specific Docker network
docker network inspect "network_name"      # Display detailed information about a network

# COMPOSE
docker compose -f "compose_file" up -d     # Create and start containers in detached mode using the specified compose file
    --force-recreate                       # Recreate containers even if their configuration and image haven't changed
    --build                                # Build images before starting containers
docker compose -f "compose_file" start     # Start existing containers defined in the compose file
docker compose -f "compose_file" down      # Stop and remove containers, networks, images, and volumes defined in the compose file
docker compose -f "compose_file" logs      # View output from containers defined in the compose file
docker compose -f "compose_file" stop      # Stop running containers without removing them
docker compose -f "compose_file" restart   # Restart all containers defined in the compose file
```

### Further Resources

- [Docker Documentation](https://docs.docker.com/guides/)

##

![nginx_banner](https://github.com/user-attachments/assets/9aabe762-845d-4c7b-bf07-4f4e61cd4cce)

### What is NGINX

First, lets start with setting up an NGINX server inside of a Container. Nginx in Docker lets you run a high-performance web server in a container. This allows for easy deployment, isolation, and scalability of your web application. You can leverage pre-built Nginx images from Docker Hub, or create your own custom image using a Dockerfile, what we will do here. The Dockerfile can define the base image, configuration files, and additional software your Nginx server needs to run your specific web application. Configuring Nginx within the container allows it to handle requests and serve your web content. We will create a Dockerfile which basically installs nginx inside of a Container, and starts nginx according to the configurations we specify in the config file.

### Configuration File

In the **nginx.conf** file, we start by defining the configuration for one server. 

- The way nginx and its modules work is determined in the configuration file.
- By default, the configuration file is named `nginx.conf` and placed in the directory `/usr/local/nginx/conf`, `/etc/nginx`, or `/usr/local/etc/nginx`.
- Our server will listen on port 80 (HTTP & IPv6) for connections
- We set localhost as the name of our server
- We define where and in which order nginx will search for HTML files in order to serve them

```

http {
    server {
        listen 80;
        listen [::]:80;
        server_name localhost;

        root /usr/share/nginx/html;
        index index.html index.htm;
    }
}
```

### Dockerfile

This Dockerfile builds our first custom Nginx web server image. 

```docker
# base image
FROM debian:bullseye

# update package manager
RUN apt-get update -y && apt-get upgrade -y

# install nginx and openssl
RUN apt-get install -y nginx openssl

# clean up cached package files
RUN rm -rf /var/lib/apt/lists/*

# copy custom NGINX config file from our host machine into container
COPY conf/nginx.conf /etc/nginx/nginx.conf

# expose HTTP and HTTPS ports to allow external connections
EXPOSE 443

# start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
```

### Run the nginx container

In the folder where the Dockerfile and nginx.conf file are located, we can now execute the following command to first build an image and then run the container based on that image

`docker build -t my-nginx-image .`

`docker run -p 80:80 nginx-image`

Afterwards, you should be served the nginx default page when accessing [localhost:80](http://localhost:80) in your browser.

### **Conforming to  TLSv1.2 and TLSv1.3**

**What is TLS?**

TLS (Transport Layer Security) v1.2 and v1.3 are the latest versions of the TLS protocol, which evolved from SSL (Secure Sockets Layer), a security protocol originally developed for encrypting internet communications.

**Updating Dockerfile:**

- As we will need to create a certificate and a key for the TLS protocol, we first install openssl. Openssl is a package,which provides cryptographic functions for secure communication and lets us create the certificate and key.
- The next step is to create the folder in which the two files will be stored: /etc/nginx/ssl
- Then we continue and create the certificate and key and save them in the newly created folder. We start with the openssl req command, which lets us create certificate and key.
    - -x509 specifies that we want a self-signed certificate
    - -nodes specifies that no passphrase is required. We do this as it should run without an interaction needed by the user.
    - After specifying the path where the files will be saved, we continue to specify the information that will be embedded in the certificate (Country, Organization, Common Name, …).

```docker

# base image
FROM debian:bullseye

# update package manager
RUN apt-get update -y && apt-get upgrade -y

# install nginx and openssl
RUN apt-get install -y nginx openssl

# clean up cached package files
RUN rm -rf /var/lib/apt/lists/*

# copy custom NGINX config file into container
COPY conf/nginx.conf /etc/nginx/nginx.conf

# TSL SETUP
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=localhost/UID=login"

# expose HTTP and HTTPS ports to allow external connections
EXPOSE 443

# start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
```

### Updating nginx.conf file:

We also need to make some adjustments in the nginx.conf file in order to confirm to TLS:

- first of all we change the port from 80 to 443, as port 80 can only handle HTTP, while port 443 can handle HTTPS.
- Then we explicitly specify, that we want to confirm to TLSv1.2 or TLSv1.3
- We also specify the location of the certificate and key we created with the Dockerfile
- Lastly we add the event block outside of the http block. This appeared to be necessary during debugging and specifies how many connections each worker process can handle.

```
# Events module settings
events {
    worker_connections 1024;
}

http {
  server {
      server_name localhost;
      listen 443 ssl;
      listen [::]:443 ssl;
      ssl_protocols TLSv1.2 TLSv1.3;
			ssl_certificate /etc/nginx/ssl/inception.crt;
			ssl_certificate_key /etc/nginx/ssl/inception.key;
      root /usr/share/nginx/html;
      index index.php index.html index.htm;
  }
}
```

After making the above changes, we can now run the following commands:

`docker build -t my-nginx-image .`

`docker run -p 443:443 nginx-image`

When we go back to our browser and connect to localhost, we can see that now a https connection will be established. (If your browser suggests a security risk, you can ignore this and accept it).

### Changing the hostname and domain

As the subject requires us to change the domain name to intra_login.42.fr, we proceed to make the following changes:

- In the nginx.config file we change the server_name, to in my case lgrimmei.42.fr
- In the Dockerfile, where we specify the embedded information of the certificate, we change
    - CN=localhost to CN=lgrimmei.42.fr
    - UID=login to CN=lgrimmei.42.fr
- And lastly we add the following line to our hosts file on the host machine: 127.0.0.1 lgrimmei.42.fr”

After rerunning the container and possibly also cleaning the cache of the browser we will now be able to access nginx at https://lgrimmei.42.fr

### Fine tuning the nginx.conf file

Even though the configuration file for nginx works as is, in the following i wanted to add some more settings in order to improve it.

- First we add two new lines outside of the http block, that tell nginx to automatically decide on the amount of worker processes and choose the optimal number. We also save the process id in a dedicated file.
- We also define a new location block, which will make sure to test the requested uri (path) first. If the requested uri does not exist, it will automatically check for a directory with the same name, and if that did not work it will return the 404 error page.
- Lastly we specify the paths for the log files in order to facilitate debugging

```
# Worker process configuration
user www-data;
worker_processes auto;
pid /run/nginx.pid;

# Events module settings
events {
  worker_connections 1024;
}

http {
  server {
      # SSL settings
      server_name lgrimmei.42.fr;
      listen 443 ssl;
      listen [::]:443 ssl;
      ssl_protocols TLSv1.2 TLSv1.3;
			ssl_certificate /etc/nginx/ssl/inception.crt;
			ssl_certificate_key /etc/nginx/ssl/inception.key;

      # File system settings
      root /usr/share/nginx/html; # /var/www/html
      index index.php index.html index.htm;
      location / {
          try_files $uri $uri/ =404;
      }

      # Log settings
      access_log /var/log/nginx/access.log;
      error_log /var/log/nginx/error.log;
  }
}
```


##
![mariadb-banner](https://github.com/user-attachments/assets/d361e358-99c7-4d78-af5e-8bbc14a2365a)

### What is MariaDB?

MariaDB is a database management system based on MySQL, using tables of rows and columns to efficiently organize data. In our set of containers MariaDB will be responsible for persisting our data. It basically serves as the storage for our Wordpress and Nginx containers which can run more effective when working with a MariaDB container.

In order to launch the MariaDB container we obviously need to create a Dockerfile. In addition we will also create a config file, as well as a script which will be responsible for creating our initial database.

**Dockerfile**

```docker
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
```

### Database Creation script

In order to create a database and user in our MariaDB server, we will make use of a bash script that executes the commands to achieve this. This script will be called via Entrypoint in our Dockerfile as shown above.

- first we start our MariaDB server in the background and wait until the the startup was successful
- After checking if the database was already created, we tackle the database and user setup, while connecting to the server via our root.
    - we create the database and user if they do not already exist
    - we grant all privileges to the user we created and flush those changes in order to make them take effect
    - each of these lines is followed by a error message that will be executed in case we encounter an error
- Lastly we shutdown and restart our mysql service in the foreground, to make sure all changes take effect and keep the container running

```bash
#!/bin/bash

# Start MariaDB server
mysqld_safe --datadir='/var/lib/mysql' &
until mysqladmin ping -uroot -p"$(cat "$MDB_ROOT_PW")" --silent; do
    echo "Waiting for MariaDB to start..."
    sleep 1
done

# Check if database already exists
DB_EXISTS=$(mysql -uroot -p"$(cat "$MDB_ROOT_PW")" -e "SHOW DATABASES LIKE '$MDB_DB_NAME'" | grep "$MDB_DB_NAME" > /dev/null; echo "$?")

# Create database if it does not exist
if [ "$DB_EXISTS" -eq 1 ]; then
    echo "Database does not exist. Creating database and user..." >> /var/log/mariadb_env_vars.log
    mysql -uroot -p"$(cat "$MDB_ROOT_PW")" -e "CREATE DATABASE IF NOT EXISTS \`$MDB_DB_NAME\`" || { echo 'Failed to create database' >> /var/log/mariadb_env_vars.log; exit 1; }
    mysql -uroot -p"$(cat "$MDB_ROOT_PW")" -e "CREATE USER IF NOT EXISTS '$MDB_USER'@'%' IDENTIFIED BY '$(cat "$MDB_PW")'" || { echo 'Failed to create user' >> /var/log/mariadb_env_vars.log; exit 1; }
    mysql -uroot -p"$(cat "$MDB_ROOT_PW")" -e "GRANT ALL PRIVILEGES ON \`$MDB_DB_NAME\`.* TO '$MDB_USER'@'%'" || { echo 'Failed to grant privileges' >> /var/log/mariadb_env_vars.log; exit 1; }
    mysql -uroot -p"$(cat "$MDB_ROOT_PW")" -e "FLUSH PRIVILEGES;" || { echo 'Failed to flush privileges' >> /var/log/mariadb_env_vars.log; exit 1; }
    echo "Database and user created successfully." >> /var/log/mariadb_env_vars.log
else
    echo "Database already exists. Skipping creation." >> /var/log/mariadb_env_vars.log
fi

# Stop the MariaDB service started by the service command
mysqladmin shutdown -uroot -p"$(cat "$MDB_ROOT_PW")"

# Start MariaDB in the foreground to keep the container running
exec mysqld_safe --datadir='/var/lib/mysql'
```

### Config File

Below we have the configuration file, which will be used during the creation of our MariaDB server. MariaDB utilizes the file located at the path `/etc/mysql/mariadb.conf.d/50-server.cnf`, which is why we copied it there with the help of our Dockerfile.

```
# Configuration section of MySQL server
[mysqld]
# define directory to store data files
datadir = /var/lib/mysql
# define location to store process
pid-file = /run/mysqld/mysqld.pid
# define path to socket file
socket  = /run/mysqld/mysqld.sock
# define IP adresses to listen to, here set to all as we do not need to restrict anything, as we are not in a prod environment
bind_address=*
# define default port to listen to
port = 3306
# define the user that mariaDB runs as
user = mysql
```

### .env file

As recommended in the subject, in our .env file, we will declare variables like the domain name or MariaDB passwords as environmental variables and therefore increase the security. We will incorporate these environmental variables in our containers by adding the `--env-file srcs/.env` during compiling. Keeping your credentials in an env file is bad practice tho, and we will tackle this as soon as possible, but for now we should be able to also start up our mariadb Container.

```
DOMAIN_NAME=lgrimmei.42.fr
MYSQL_USER=lgrimmei
MYSQL_DB_NAME=database
MYSQL_PW=ilove42
MYSQL_ROOT_PASSWORD=ilove42
```

##
![docker-compose](https://github.com/user-attachments/assets/6d2071f2-6769-49bc-827b-6ab792be6087)

### Move to docker-compose file

As we have more than one container now (nginx and mariadb), and we will ultimately need to move to a docker-compose.yml (yaml file) anyways, we will now create one. As already described in the introduction, some advantages of using yaml files are the simplified management of multiple containers at once, as we can start all of them inside of one file, their ease of use and that they act as a single source of truth for our projects architecture.

**Commands to utilize a yaml file:**

```yaml

# Running containers
docker compose -f "compose_file" up -d     # Create and start containers in detached mode using the specified compose file
    --force-recreate                       # Recreate containers even if their configuration and image haven't changed
    --build                                # Build images before starting containersdocker-compose build # build / rebuild
docker-compose -f "compose_file" start     # start existing container
docker-compose -f "compose_file" restart   # restart all containers defined in yaml

# Stopping 
docker-compose -f "compose_file" down      # stop and remove contianers
docker-compose -f "compose_file" stop      # stop container

# More
docker-compose -f "compose_file" ps        # list all containers
docker-compose -f "compose_file" exec ...  # execute command inside of container
docker-compose -f "compose_file" logs      # display logs of containers
docker-compose -f "compose_file" rm        # remove stopped containers
docker-compose -f "compose_file" kill      # force stop and remove containers

```

### docker-compose.yml

After specifying the file format version, we can start to define our different services, while each services runs its own container. 

The first service we want to run is nginx, for which we start specifying the path to the Dockerfile we created earlier inside the build block. In the ports block we map port 433 of the host machine to port 433 of the container for the communication between those two. We also specify that our .env file should be integrated in the container as an environment file and configure the restart policy, so it always restarts. Afterward we configure the mariadb server, which follows the same pattern as the nginx sevice.

```
version: "3.8"

services:
  nginx:
    build:
      context: ../
      dockerfile: srcs/requirements/nginx/Dockerfile
    ports: 
      - "443:443"
    env_file:
      - .env
    restart: unless-stopped

  mariadb:
    build:
      context: ../
      dockerfile: srcs/requirements/mariadb/Dockerfile
    ports: 
      - "3306:3306"
    env_file:
      - .env
    restart: unless-stopped
```


##
![Screenshot from 2024-07-27 22-29-48](https://github.com/user-attachments/assets/e57ff8ab-ccdc-42fd-8829-f74b181ccd6d)

As the subject also requires a Makefile, we can now create one and add some commands to properly manage our containers. Our default target will be ‘help’, which will display all targets and a short information on them on the terminal. The ‘init’ target will run a bash script, which initializes our environment, folders and secrets, what will be explained later on.

```
# FILES AND DIRS
COMPOSE_FILE	:= srcs/docker-compose.yml
INIT_SCRIPT		:= ./srcs/init.sh
SECRETS_DIR		:= ./secrets
DATA_DIR		:= ../../data
ENV_FILE		:= ./srcs/.env

# Help message
help:
	@echo "Available targets:"
	@echo "  init                   - Initialize data folders, credentials, and environment"
	@echo "  run                    - Run the containers (detached)"
	@echo "  stop                   - Stop all running containers"
	@echo "  start                  - Start stopped containers"
	@echo "  remove                 - Remove the containers"
	@echo "  status                 - Show status of all containers"
	@echo "  clean                  - Clean up secrets and environment files and prune system"
	@echo "  help                   - Show this help message"

# Initialize data folder, credentials and environment
init:
	@echo "\e[34mInitializing Files and Credentials...\e[0m"
	@$(INIT_SCRIPT)
	@echo "\e[32mInitialization complete\e[0m"

# Run containers in detached mode
run: 
	@echo "\e[34mStarting containers ......\e[0m"
	@docker compose -f $(COMPOSE_FILE) up -d --force-recreate --build
	@echo "\e[32mContainers started\e[0m"

# Stop all running containers
stop:
	@echo "\e[34mStopping all containers ...\e[0m"
	docker stop $$(docker ps -q) > /dev/null 2>&1 || true
	@echo "\e[32mContainers stopped\e[0m"

# Start stopped containers
start:
	@echo "\e[34mStarting stopped containers ...\e[0m"
	docker compose -f $(COMPOSE_FILE) start
	@echo " \e[32mContainers started\e[0m"

# Remove all containers
remove:
	@echo "\e[34mRemoving containers ...\e[0m"
	@if [ ! -f $(ENV_FILE) ]; then touch $(ENV_FILE); fi
	@docker compose -f $(COMPOSE_FILE) down
	@echo "\e[32mContainers removed\e[0m"

# Show status of all containers
status:
	@echo "\e[34mIMAGES OVERVIEW\e[0m"
	@docker images
	@echo "\e[34mCONTAINER OVERVIEW\e[0m"
	@docker ps -a
	@echo "\e[34mNETWORK OVERVIEW\e[0m"
	@docker network ls
	@echo "\e[34mCONTAINER LOGS\e[0m"
	@if [ ! -f $(ENV_FILE) ]; then touch $(ENV_FILE); fi
	@docker compose -f $(COMPOSE_FILE) logs

# Clean up secrets and environment files and prune docker system
clean: remove
	@echo "\e[34mCleaning up secrets and environment files ...\e[0m"
	@rm -fr $(SECRETS_DIR) || true
	@rm -fr $(ENV_FILE) || true
	@rm -fr $(DATA_DIR) || true
	@echo "\e[32mClean up complete\e[0m"
	@echo "\e[34mPruning Docker system ...\e[0m"
	@docker system prune --all --force
	@echo "\e[32mPrune complete\e[0m"

.PHONY: all init run stop start down status clean
```

##
![wordpress-logo-banner](https://github.com/user-attachments/assets/c3de87bf-9754-470d-b6a6-59be27a61276)

### What is WordPress?

WordPress is a popular open-source content management system (CMS) used for creating and managing websites and blogs. It is known for its user-friendly interface, extensive plugin ecosystem, and customizable themes, making it accessible for both beginners and advanced users. In our Docker stack, WordPress is used as the CMS container that handles our website's content and presentation. In order to properly setup our WordPress container, we again have to write a Dockerfile and a script that installs WordPress and creates a mysql database for it.

**Dockerfile**

```docker
# base image
FROM debian:bullseye

RUN mkdir -p /var/www/wordpress

# update package manager
RUN apt-get update -y && apt-get upgrade -y

# install packages
RUN apt-get install -y wget php php7.4-fpm php-mysql mariadb-client curl netcat-traditional sendmail

# clean up cached package files
RUN rm -rf /var/lib/apt/lists/

# copy WordPress config script into container
COPY srcs/requirements/wordpress/tools/wp_config.sh /usr/local/bin/wp_config.sh

# change executable rights of database creation script
RUN chmod +x /usr/local/bin/wp_config.sh

# define WordPress config script to run when container starts
ENTRYPOINT ["/usr/local/bin/wp_config.sh"]
```

**wp_config.sh**

In our WordPress configuration script, we basically do the following three things:

- First we wait for our mariadb server to be up and running, what is a prerequisite for the rest of the script
- Then we install WordPress inside of our container and configure it according to our needs while also creating a database for it
- Our last step then is to configure php-fpm and start it in the foreground to keep the Container running

```
#!/bin/bash

### WAIT FOR MARIADB SERVER TO BE RUNNING
end_time=$((SECONDS + 10))
while (( SECONDS < end_time )); do
    if nc -zq 1 mariadb 3306; then
        echo "[### MARIADB IS UP AND RUNNING ###]"
        break
    else
        echo "[### WAITING FOR MARIADB TO START... ###]"
        sleep 1
    fi
done

if (( SECONDS >= end_time )); then
    echo "[### MARIADB IS NOT RESPONDING ###]"
fi

### INSTALL WordPress
# install WordPress CLI (command line interface)
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# make the wp command globally executable
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp 

# go to WordPress directory and change its permission and owner so nginx can work with it
cd /var/www/wordpress
chmod -R 755 /var/www/wordpress/
chown -R www-data:www-data /var/www/wordpress

# download WordPress into /var/www/WordPress directory
wp core download --allow-root

# create wp-config.php file with details
wp core config --dbhost=mariadb:3306 --dbname="$MDB_DB_NAME" --dbuser="$MDB_USER" --dbpass="$(<"$MDB_PW")" --allow-root

# install WordPress with details
wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_NAME" --admin_password="$(<"$WP_ADMIN_PW")" --admin_email="$WP_ADMIN_EMAIL" --allow-root

# create new user
wp user create "$WP_USER_NAME" "$WP_USER_EMAIL" --user_pass="$(<"$WP_USER_PW")" --role="$WP_USER_ROLE" --allow-root

### CONFIGURE PHP

# change listen port from unix socket to 9000
sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf

# create a directory for php-fpm
mkdir -p /run/php

# start php-fpm service in the foreground to keep the container running
/usr/sbin/php-fpm7.4 -F
```

##
![php-fpm-low-memory](https://github.com/user-attachments/assets/66e1a20b-0007-4501-94e4-c9d7237b979c)


### **CGI**

In order to continue with our project, we need to quickly take a little detour and introduce CGI. **CGI** stands for **Common Gateway Interface**. It's a way for a web server to interact with external programs, often scripts, to generate web pages dynamically.

Let me try to explain, using a restaurant as reference: Think of a web server as a restaurant. When you (the user) go to the restaurant, you place an order (make a request) with the waiter (the web server). The waiter then takes your order to the kitchen (the external program or script) to prepare your food (generate the web page). Once the food is ready, the waiter brings it back to you.

### How CGI Works

1. **User Request**: You open your web browser and type in a URL or click on a link what sends a request to the web server.
2. **Server Receives Request**: The web server receives your request and sees that it needs to run a CGI script to generate the response.
3. **Server Runs the Script**: The web server starts the CGI script, which can include accessing a database, processing data, etc..
4. **Script Generates Output**: The script generates some output, usually in the form of HTML which will makes up our web pages.
5. **Server Sends Response**: The web server takes the output from the script and sends it back to your web browser.
6. **Browser Receives Request:** Your browser then displays the web page.

So in summary CGI is a way for web servers to run external programs to generate web pages dynamically. It allows websites to be interactive and respond to user input, rather than just serving static pages. However, CGI can be slow because it starts a new process for each request, which is why more modern methods like FastCGI and PHP-FPM are often used today.

### **PHP-FPM (PHP FastCGI Process Manager)**

**FastCGI** is a protocol for interfacing interactive programs with a web server. It is an improvement over the older CGI protocol, providing better performance by keeping the PHP interpreter running between requests, thus avoiding the overhead of starting and stopping a process for each request.

**Advantages of Using PHP-FPM and FastCGI ocer traditional CGI with WordPress and Nginx**

1. Improved Performance through Persistent Processes and load balancing
2. Better Resource Management thorugh configuration flexibility
3. Scalability
4. Security
5. Compatibility with Nginx

**How It Works in our Docker Stack**

1. **Nginx Container: A**cts as the web server, handling incoming HTTP requests and forwarding PHP requests to the PHP-FPM process using the FastCGI protocol.
2. **WordPress Container with PHP-FPM installed**: Processes PHP code for WordPress and manages PHP processes efficiently.
3. **MariaDB Container**: Stores the WordPress database, which PHP-FPM accesses to retrieve and store data.

### Congiguring PHP in our Containers

Next do downloading and running php-fpm in our wordpress container, we will also need to make some adjustments in our earlier work to make sure php-fpm is properly integrated in our system:

**nginx.conf**

In our configuration for the nginx server, we need to make a few adjustments in order to properly handle the .php files.

- We includes a configuration file (fastcgi-php.conf) that contains common FastCGI parameters for PHP
- Then we need to make sure that our PHP requests are passed to the wordpress server containing php-fpm on port 9000.
- The fastcgi_param line basically sets the SCRIPT_FILENAME parameter, which tells the FastCGI server the path to the script that needs to be executed.
- Afterward we include another configuration file (fastcgi_params) that sets additional FastCGI parameters. These parameters are necessary for the proper functioning of PHP-FPM with Nginx.

```
# Worker process configuration
user www-data;
worker_processes auto;
pid /run/nginx.pid;

# Events module settings
events {
  worker_connections 1024;
}

http {
  server {
      # SSL settings
      server_name lgrimmei.42.fr;
      listen 443 ssl;
      listen [::]:443 ssl;
      ssl_protocols TLSv1.2 TLSv1.3;
			ssl_certificate /etc/nginx/ssl/inception.crt;
			ssl_certificate_key /etc/nginx/ssl/inception.key;

      # File system settings
      root /usr/share/nginx/html; # /var/www/html
      index index.php index.html index.htm;
      location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass wordpress:9000;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
      }

      # Log settings
      access_log /var/log/nginx/access.log;
      error_log /var/log/nginx/error.log;
  }
}
```

**Update docker-compose.yml**

To include the WordPress container in our Application, we also have to add a new WordPress service to the docker-compose.yml file. This will follow the same pattern as the nginx and mariadb service and can look like follows:

```
services:

  mariadb:
    container_name: mariadb
    build:
      context: ../
      dockerfile: srcs/requirements/mariadb/Dockerfile
    ports: 
      - "3306:3306"
    env_file:
      - .env
    restart: unless-stopped
 
  wordpress:
    container_name: wordpress
    build:
      context: ../
      dockerfile: srcs/requirements/wordpress/Dockerfile
    env_file:
      - .env
    depends_on:
      - mariadb
    restart: unless-stopped
    
  nginx:
    container_name: nginx
    build:
      context: ../
      dockerfile: srcs/requirements/nginx/Dockerfile
    ports: 
      - "443:443"
    env_file:
      - .env
    depends_on:
      - wordpress
    restart: unless-stopped
```

##
![Screenshot from 2024-07-30 17-18-59](https://github.com/user-attachments/assets/3c7fa8fe-81bc-4611-a321-365059b5f43f)


### What are Docker Secrets?

Docker Secrets is a feature of Docker that allows us to securely manage sensitive data, such as passwords, API keys, and certificates, within our Docker containers. It helps us in preventing unauthorized access and accidental leaks of sensitive data. Docker secrets will be encrypted and stored by Docker, which makes them only accesible to a service if we explicitly define it. Inside our Container we can then access the secrets in the /run/secrets directory. In our yaml file, we will therefore add the ‘environment’ and ‘secrets’ block to all of our services, while saving the path to the secrets file in the environment and making the secret accesible in the secrets block. Furthermore we will also need to create a secrets block separated from the services, where we define our secrets.

```
services:

  mariadb:
    container_name: mariadb
    build:
      context: ../
      dockerfile: srcs/requirements/mariadb/Dockerfile
    ports: 
      - "3306:3306"
    env_file:
      - .env
    restart: unless-stopped
    environment:
      MDB_PW: /run/secrets/mdb_pw
      MDB_ROOT_PW: /run/secrets/mdb_root_pw
    secrets:
      - mdb_pw
      - mdb_root_pw


  wordpress:
    container_name: wordpress
    build:
      context: ../
      dockerfile: srcs/requirements/wordpress/Dockerfile
    env_file:
      - .env
    depends_on:
      - mariadb
    restart: unless-stopped
    environment:
      MDB_PW: /run/secrets/mdb_pw
      WP_ADMIN_PW: /run/secrets/wp_admin_pw
      WP_USER_PW: /run/secrets/wp_user_pw
    secrets:
      - mdb_pw
      - wp_admin_pw
      - wp_user_pw
    
  nginx:
    container_name: nginx
    build:
      context: ../
      dockerfile: srcs/requirements/nginx/Dockerfile
    ports: 
      - "443:443"
    env_file:
      - .env
    depends_on:
      - wordpress
    restart: unless-stopped
    secrets:
      - key
      - cert

secrets:
  mdb_pw:
    file: ../secrets/db_password.txt
  mdb_root_pw:
    file: ../secrets/db_root_password.txt
  wp_admin_pw:
    file: ../secrets/wp_root_password.txt
  wp_user_pw:
    file: ../secrets/wp_user_password.txt
  cert:
    file: ../secrets/inception.crt
  key:
    file: ../secrets/inception.key
```

##
![Screenshot from 2024-07-30 15-23-47](https://github.com/user-attachments/assets/69fe1f26-8037-416e-b0ad-21d66d67a030)

### Setting up Volumes and a Network

Now that we have all our three services up and running, we need to set up a Docker Network through wich the services can properly communicate, as well as the Volumes so our data persists on our machine through Docker startups.

**Docker Volumes** are a mechanism for persisting data generated by and used by Docker containers. They are designed to be independent of the container life-cycle, meaning that data stored in volumes is not deleted when the container is removed. Volumes can also be shared between multiple containers, offer good performance and are easy to back up and restore. We can create a new Volume by defining it in a separate block in the yaml file and then add it to our service. In our case we create a volume for mariadb and WordPress at the folders we created in the init.sh script. The definition of our volumes include the volume name and the volume driver, which will be set to local and will store our data on our local file system. The further specifications for the driver include the device (path to the folder), the extra option bind (which lets us mount the directory from our host into the container) and the type of none (which indicates, that no special file system is used).

The **Docker Network** we will create, will enable communication between Docker containers. Networks provide isolated environments where containers can securely and efficiently communicate with each other.  Among others, Docker Networks facilitate scalability, as new containers can join the network and communicate with existing containers without additional configuration.

After adding our Secrets, Volumes and the Network to the docker-compose file, it could look like this:

```
services:

  mariadb:
    container_name: mariadb
    build:
      context: ../
      dockerfile: srcs/requirements/mariadb/Dockerfile
    ports: 
      - "3306:3306"
    env_file:
      - .env
    networks:
      - inception
    volumes:
      - mariadb:/var/lib/mysql
    restart: unless-stopped
    environment:
      MDB_PW: /run/secrets/mdb_pw
      MDB_ROOT_PW: /run/secrets/mdb_root_pw
    secrets:
      - mdb_pw
      - mdb_root_pw


  wordpress:
    container_name: wordpress
    build:
      context: ../
      dockerfile: srcs/requirements/wordpress/Dockerfile
    env_file:
      - .env
    depends_on:
      - mariadb
    volumes:
      - wordpress:/var/www/wordpress
    networks:
      - inception
    restart: unless-stopped
    environment:
      MDB_PW: /run/secrets/mdb_pw
      WP_ADMIN_PW: /run/secrets/wp_admin_pw
      WP_USER_PW: /run/secrets/wp_user_pw
    secrets:
      - mdb_pw
      - wp_admin_pw
      - wp_user_pw
    
  nginx:
    container_name: nginx
    build:
      context: ../
      dockerfile: srcs/requirements/nginx/Dockerfile
    ports: 
      - "443:443"
    env_file:
      - .env
    depends_on:
      - wordpress
    volumes:
      - wordpress:/var/www/wordpress
    networks:
      - inception
    restart: unless-stopped
    secrets:
      - key
      - cert

volumes:
  mariadb:
    name: mariadb
    driver: local
    driver_opts:
      device: /home/lgrimmei/data/mariadb
      o: bind
      type: none
  wordpress:
    name: wordpress
    driver: local
    driver_opts:
      device: /home/lgrimmei/data/wordpress
      o: bind
      type: none
  
networks:
  inception:
    name: inception


secrets:
  mdb_pw:
    file: ../secrets/db_password.txt
  mdb_root_pw:
    file: ../secrets/db_root_password.txt
  wp_admin_pw:
    file: ../secrets/wp_root_password.txt
  wp_user_pw:
    file: ../secrets/wp_user_password.txt
  cert:
    file: ../secrets/inception.crt
  key:
    file: ../secrets/inception.key
```

##

### Congratulations!

After finishing the last step, we should finally be finished with our Inception Project! We can now initialize the Application with ‘make init’ and then run the Containers with ‘make run’. By opening for example https://lgrimmei.42.fr/wp-login.php we can log into our WordPress dashboard and we can also access our database through the terminal by running the command `mysql` inside of the mariadb container.

If you still did not get enough our of the project, you can further improve it, by for example adding your personal static html files, or continue with more tasks from the Bonus.








