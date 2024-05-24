# Define project name (adjust as needed)
PROJECT_NAME := inception

# Target to build the Docker image
up: clean
	@docker-compose -f srcs/docker-compose.yml build
	@docker-compose -f srcs/docker-compose.yml up


# Target to run the container (using docker-compose)
# run:
	# @docker-compose -f srcs/docker-compose.yml up

# Target to stop the container (using docker-compose)
stop:
	@docker-compose -f srcs/docker-compose.yml down

# Target to clean up (stop and remove containers)
clean: stop
	@docker-compose -f srcs/docker-compose.yml rm -f
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