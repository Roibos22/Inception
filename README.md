# INCEPTION

Welcome to my repository for the Inception project at 42 Berlin! This project involves setting up a multi-container Docker application, which includes configuring various services and ensuring they work seamlessly together. 
I wrote this guide primarily for my own learning, as this topic was entirely new to me and by documenting and repeating these concepts, I’ve gained a good understanding and can recommend doing the same.
If you spot any mistakes or have suggestions, please don't hesitate to reach out!

![Screenshot from 2024-07-27 21-54-32](https://github.com/user-attachments/assets/862541a5-7fd2-403d-9c64-8899c24bdf4b)

## INTRODUCTION TO DOCKER

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

### **What is Docker Compose?**

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

### Resources

- [Docker Documentation](https://docs.docker.com/guides/)

**NGINX**

# NGINX

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

**Dockerfile**

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

**Run the nginx container**

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

**Updating nginx.conf file:**

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
