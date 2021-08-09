# Python

## Local setup

Install [pyenv](https://github.com/pyenv/pyenv) and [pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv). Respectively for Python version management and virtualenvs management. 

> `pyenv-virtualenv` uses `python -m venv` (Python 3.3+) if it is available and the `virtualenv` command if not

---
#### On Mac
```sh
brew install pyenv-virtualenv
```
#### On Linux (Debian)
```sh
sudo apt-get update; sudo apt-get install make build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

curl https://pyenv.run | bash
```
---

```sh
echo '''
# pyenv-virtualenv
# see https://github.com/pyenv/pyenv-virtualenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
''' >> ~/.zshrc

source ~/.zshrc
```

## Configure a [Python 3](https://www.python.org/download/releases/3.0/) virtualenv

```sh
pyenv install --list | grep 3.9 | less # list possible python versions

pyenv install 3.9.6 # install a python version
pyenv virtualenv 3.9.6 python3 # create a new virtualenv
pyenv activate python3 # activate virtualenv
```

Other useful `pyenv` commands:
```sh
pyenv deactivate # deactivate current virtualenv

pyenv versions # list installed python versions and available virtualenvs
pyenv which python # see path to python executable
pyenv version-name # see current virtualenv

pyenv uninstall python3 # remove virtualenv / python version
```

## Generate a `.python-version` file

```sh
pyenv version-name > .python-version 
```

`.python-version` is then used by `pyenv-virtualenv` to automatically switch to correct virtualenv.

## Generate a `requirements.txt` file

```sh
# create a new virtualenv
pyenv virtualenv 3.9.6 NAME
# install dependencies 
pip install DEPENDENCY_1 DEPENDENCY_2
# freeze requirements
pip freeze > requirements.txt
```

## Install dependencies from a requirements.txt file

```sh
pip install -r requirements.txt
```

## Containerized Python development

- [Read the Docker blog post series](https://www.docker.com/blog/tag/python-env-series/)
