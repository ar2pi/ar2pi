SHELL := /bin/bash
NOCOLOR := \033[0m
CYAN := \033[0;36m
PINK := \033[0;35m

.SHELLFLAGS: -ceu

.PHONY: install
install:
	@echo -e "${PINK}=== Installing requirements"
	@echo -en "${CYAN}"
	pip install --upgrade pip \
		&& pip install -r requirements.txt
	@echo -e "${PINK}=== Configuring hooks"
	@echo -en "${CYAN}"
	git config --local core.hooksPath hooks
	@echo -e "${PINK}=== Checking out submodules"
	@echo -en "${CYAN}"
	git submodule update --init
	@echo -e "${PINK}=== Done."

.PHONY: build
build:
	@echo -en "${CYAN}"
	mkdocs build

.PHONY: deploy
deploy:
	@echo -en "${CYAN}"
	cd ar2pi.github.io \
		&& mkdocs gh-deploy --config-file ../mkdocs.yml
	git pull --recurse-submodules --no-rebase --ff

.PHONY: serve
serve:
	@echo -en "${CYAN}"
	mkdocs serve
