.DEFAULT_GOAL := help

.PHONY: docker
docker:	## Builds the Docker image for `4c-project` management
	docker-compose build --pull 4c-project

.PHONY: shell
shell: ## Spawns a `bash` shell in a `4c-project` container
	docker-compose run --rm 4c-project shell

.PHONY: clean
clean:	## Stops and removes running containers
	docker-compose rm --stop --force -v

.PHONY: mrproper
mrproper: clean	## Stops and removes running containers
	rm -rf build

.PHONY: build
build:	## Builds application and tests executables, with a `4c-project` container
	docker-compose run --rm 4c-project build

.PHONY: format
format:	## Formats C++ code using clang-format (with Webkit style, by default)
	docker-compose run --rm 4c-project format

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
