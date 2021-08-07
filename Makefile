install:
	@echo "=== Installing requirements ==="
	pip install -r requirements.txt
	@echo "=== Configuring hooks ==="
	git config --local core.hooksPath hooks
	@echo "=== Done. ==="

build:
	mkdocs build

deploy:
	git pull --recurse-submodules
	cd ar2pi.github.io \
		&& mkdocs gh-deploy --config-file ../mkdocs.yml \
		&& git reset --hard
	git commit -am "deploy ar2pi.github.io" \
		&& git push

serve:
	mkdocs serve