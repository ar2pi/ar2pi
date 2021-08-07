.SHELLFLAGS: -ceu

SHELL := /bin/bash
NOCOLOR := \033[0m
CYAN := \033[0;36m
PINK := \033[0;35m

install:
	@echo -e "${PINK}=== Installing requirements"
	@echo -en "${CYAN}"
	pip install -r requirements.txt
	@echo -e "${PINK}=== Configuring hooks"
	@echo -en "${CYAN}"
	git config --local core.hooksPath hooks
	@echo -e "${PINK}=== Done."

build:
	@echo -en "${CYAN}"
	mkdocs build

deploy:
	@echo -en "${CYAN}"
	git pull --recurse-submodules
	cd ar2pi.github.io \
		&& mkdocs gh-deploy --config-file ../mkdocs.yml \
		&& git reset --hard

serve:
	@echo -en "${CYAN}"
	mkdocs serve