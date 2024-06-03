# Define project name (adjust as needed)
PROJECT_NAME := inception

stop:
	docker-compose -f srcs/docker-compose.yml down || true

stop-containers:
	RUNNING_CONTAINERS=$(docker ps -a -q)
	if [ ! -z "$RUNNING_CONTAINERS" ]; then docker kill $RUNNING_CONTAINERS; fi

delete-containers:
  @docker system prune -f || true

delete-images:
  @docker rmi $(docker images -a -q -f dangling=true) || true

clean docker: stop stop-containers delete-containers delete-images

# Target to build the Docker image
build:
	docker-compose -f srcs/docker-compose.yml --env-file srcs/.env build -d

up: build
	docker-compose -f srcs/docker-compose.yml --env-file srcs/.env up -d

# Target to stop the container (using docker-compose)

# Target to clean up (stop and remove containers)
clean: stop
	@docker-compose -f srcs/docker-compose.yml rm -f
	# @docker rm $(docker ps -a -q)
	@echo docker rmi $(docker images -a -q) -f

# Default target to run the container
.PHONY: all

all: up

# Help target
help:
	@echo "Available targets:"
	@echo "  build        - Build the Docker image"
	@echo "  run          - Run the container (detached)"
	@echo "  stop         - Stop the container"
	@echo "  clean        - Stop and remove containers"
	@echo "  all          - Run the container (default)"
	@echo "  help         - Show this help message"