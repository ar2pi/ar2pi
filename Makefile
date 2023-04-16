SHELL := /bin/bash
GH_PAGE := ar2pi.github.io
GH_BOT_USER_NAME := 🤖
GH_BOT_USER_EMAIL := bot@ar2pi.net

# https://www.gnu.org/software/bash/manual/bash.html#Invoking-Bash
# https://www.gnu.org/software/bash/manual/bash.html#Modifying-Shell-Behavior
.SHELLFLAGS: -ceu

install:
	pip install --upgrade pip
	pip install -r requirements.txt
	git config --local core.hooksPath hooks
	git submodule update --init
	cd $(GH_PAGE) && git config --local user.name $(GH_BOT_USER_NAME)
	cd $(GH_PAGE) && git config --local user.email $(GH_BOT_USER_EMAIL)

build:
	mkdocs build

serve:
	mkdocs serve

deploy:
	cd $(GH_PAGE) && mkdocs gh-deploy --config-file ../mkdocs.yml --remote-branch main

update-build-version:
	git submodule update --remote --checkout
	git add $(GH_PAGE)
	git -c user.name="${GH_BOT_USER_NAME}" -c user.email="$(GH_BOT_USER_EMAIL)" commit --author "$(GH_BOT_USER_NAME) <$(GH_BOT_USER_EMAIL)>" -m "ci: update build version"

publish: deploy update-build-version
	git push --no-verify
