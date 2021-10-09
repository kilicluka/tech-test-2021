DC = docker-compose -p address_book -f docker/docker-compose.yml

.PHONY: help
help:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

.PHONY: build
build: ## Build the docker images needed to run the server
	${DC} build

.PHONY: server
server: ## Start the Django server through docker-compose
	${DC} up -d

.PHONY: shell
shell: ## Start a new container running the bash shell
	${DC} run --rm --entrypoint="/bin/sh" server

.PHONY: clean
clean: ## Stop and remove containers created by the docker-compose up command
	${DC} down

.PHONY: server-shell
server-shell: ## Start a bash shell inside the server container
	${DC} exec server /bin/sh
