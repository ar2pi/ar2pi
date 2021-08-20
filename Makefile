SHELL := /bin/bash
GH_PAGE := ar2pi.github.io

.SHELLFLAGS: -ceu

.PHONY: install
install:
	pip install --upgrade pip
	pip install -r requirements.txt
	git config --local core.hooksPath hooks
	git submodule update --init
	cd $(GH_PAGE) && git config --local user.name "🤖"
	cd $(GH_PAGE) && git config --local user.email "bot@ar2pi.net"

.PHONY: build
build:
	mkdocs build

.PHONY: serve
serve:
	mkdocs serve

.PHONY: deploy
deploy:
	cd $(GH_PAGE) && mkdocs gh-deploy --config-file ../mkdocs.yml --remote-branch main

.PHONY: update-build-version
update-build-version:
	git submodule update --remote --checkout
	git add $(GH_PAGE)
	git -c user.name="🤖" -c user.email="bot@ar2pi.net" commit --author "🤖 <bot@ar2pi.net>" -m "ci: update build version"

.PHONY: publish
publish: deploy update-build-version
	git push --no-verify
