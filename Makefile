# Project Variables
PROJECT_NAME ?= todobackend
ORG_NAME ?= zee7han
REPO_NAME ?= todobackend

# Filenames
DEV_COMPOSE_FILE := docker/dev/docker-compose.yml
RELEASE_COMPOSE_FILE := docker/release/docker-compose.yml

# Docker Compose Projects names
REL_PROJECT := $(PROJECT_NAME)$(BUILD_ID)
DEV_PROJECT := $(PROJECT_NAME)dev

.PHONY: test build release clean

test:
	echo "Hello"
	echo "from make"
	sudo docker-compose -p $(DEV_PROJECT) -f $(DEV_COMPOSE_FILE) build
	sudo docker-compose -p $(DEV_PROJECT) -f $(DEV_COMPOSE_FILE) up agent
	sudo docker-compose -p $(DEV_PROJECT) -f $(DEV_COMPOSE_FILE) up test

build:
	echo "Hello from build"
	sudo docker-compose -p $(DEV_PROJECT) -f $(DEV_COMPOSE_FILE) up builder



release:
	echo "Hello from release"
	sudo docker-compose -p $(REL_PROJECT) -f $(RELEASE_COMPOSE_FILE) build
	sudo docker-compose -p $(REL_PROJECT) -f $(RELEASE_COMPOSE_FILE) up agent
	sudo docker-compose -p $(REL_PROJECT) -f $(RELEASE_COMPOSE_FILE) run --rm app manage.py collectstatic --noinput
	sudo docker-compose -p $(REL_PROJECT) -f $(RELEASE_COMPOSE_FILE) run --rm app manage.py migrate --noinput
	sudo docker-compose -p $(REL_PROJECT) -f $(RELEASE_COMPOSE_FILE) up test

clean:
	sudo docker-compose -p $(DEV_PROJECT) -f $(DEV_COMPOSE_FILE) kill
	sudo docker-compose -p $(DEV_PROJECT) -f $(DEV_COMPOSE_FILE) rm -f
	sudo docker-compose -p $(REL_PROJECT) -f $(RELEASE_COMPOSE_FILE) kill
	sudo docker-compose -p $(REL_PROJECT) -f $(RELEASE_COMPOSE_FILE) rm -f
