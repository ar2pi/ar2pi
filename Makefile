install:
	pip install -r requirements.txt

build:
	mkdocs build

deploy:
	git pull --recurse-submodules
	cd ar2pi.github.io && mkdocs gh-deploy --config-file ../mkdocs.yml

serve:
	mkdocs serve