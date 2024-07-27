# INCEPTION

Welcome to my repository for the Inception project at 42 Berlin! This project involves setting up a multi-container Docker application, which includes configuring various services and ensuring they work seamlessly together. 
I wrote this guide primarily for my own learning, as this topic was entirely new to me and by documenting and repeating these concepts, I’ve gained a good understanding and can recommend doing the same.
If you spot any mistakes or have suggestions, please don't hesitate to reach out!

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
