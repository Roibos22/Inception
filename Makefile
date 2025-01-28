# FILES AND DIRS
USERNAME := $(shell whoami)
COMPOSE_FILE	:= srcs/docker-compose.yml
INIT_SCRIPT		:= ./srcs/init.sh
SECRETS_DIR		:= /Users/$(USERNAME)/secrets
DATA_DIR		:= data
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
	@ docker stop $$(docker ps -q) > /dev/null 2>&1 || true
	@echo "\e[32mContainers stopped\e[0m"

# Start stopped containers
start:
	@echo "\e[34mStarting stopped containers ...\e[0m"
	@docker compose -f $(COMPOSE_FILE) start
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
