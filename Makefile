SHELL := /bin/bash

.SHELLFLAGS: -ceu

.PHONY: install
install:
	pip install --upgrade pip
	pip install -r requirements.txt
	git config --local core.hooksPath hooks
	git submodule update --init

.PHONY: build
build:
	mkdocs build

.PHONY: serve
serve:
	mkdocs serve

.PHONY: deploy
deploy:
	cd ar2pi.github.io \
		&& mkdocs gh-deploy --config-file ../mkdocs.yml

.PHONY: update-build-version
update-build-version:
	git submodule update --remote --merge
	git add ar2pi.github.io
	git commit -m "ci: update build version"

.PHONY: push
push: deploy update-build-version
	git push --no-verify
