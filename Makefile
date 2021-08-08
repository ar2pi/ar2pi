SHELL := /bin/bash
NOCOLOR := \033[0m
CYAN := \033[0;36m
PINK := \033[0;35m

.SHELLFLAGS: -ceu

.PHONY: install
install:
	@echo -e "${PINK}=== Installing requirements"
	@echo -en "${CYAN}"
	pip install -r requirements.txt
	@echo -e "${PINK}=== Configuring hooks"
	@echo -en "${CYAN}"
	git config --local core.hooksPath hooks
	@echo -e "${PINK}=== Checking out submodules"
	@echo -en "${CYAN}"
	git pull --recurse-submodules
	@echo -e "${PINK}=== Done."

.PHONY: build
build:
	@echo -en "${CYAN}"
	mkdocs build

.PHONY: deploy
deploy:
	@echo -en "${CYAN}"
	./run-deploy.sh
	git pull --recurse-submodules --ff

.PHONY: serve
serve:
	@echo -en "${CYAN}"
	mkdocs serve
