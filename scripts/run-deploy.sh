#!/bin/bash

cd ar2pi.github.io

mkdocs gh-deploy --config-file ../mkdocs.yml

git reset --hard
