PROJECT_NAME := inception

build:
	docker-compose -f srcs/docker-compose.yml --env-file srcs/.env build --no-cache

up: build
	docker-compose -f srcs/docker-compose.yml --env-file srcs/.env up -d --force-recreate

stop-containers:
	@echo -n "Stopping all containers ..." 
	@docker-compose -f srcs/docker-compose.yml stop > /dev/null 2>&1
	@echo " \e[32mdone\e[0m"

delete-containers:
	@echo -n "Removing all containers ..."
	@docker-compose -f srcs/docker-compose.yml down > /dev/null 2>&1 || true
	@echo " \e[32mdone\e[0m"

delete-images:
	@echo -n "Removing all images     ..."
	@$(eval IMAGES := $(shell docker images -a -q))
	@if [ -n "$(IMAGES)" ]; then \
        docker rmi $(IMAGES) -f > /dev/null 2>&1 || true; \
	fi
	@echo " \e[32mdone\e[0m"

clean-docker: stop-containers delete-containers delete-images

.PHONY: build up stop-containers delete-containers delete-images clean-docker all help

all: build up

help:
	@echo "Available targets:"
	@echo "  build                  - Build the Docker images"
	@echo "  up                     - Run the container (detached)"
	@echo "  stop-containers        - Stop the containers"
	@echo "  delete-containters     - Remove stopped containers"
	@echo "  delete-images          - Remove unused images"
	@echo "  clean-docker           - stop-containers, delete-containers, delete-images"
	@echo "  all                    - Build images and run the containers (default)"
	@echo "  help                   - Show this help message"