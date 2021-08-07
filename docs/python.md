# Python

## Local setup

Install [pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv)
```sh
brew install pyenv-virtualenv

echo 'eval "$(pyenv init --path)"' >> ~/.zprofile
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
```

> `pyenv-virtualenv` uses `python -m venv` (Python 3.3+) if it is available and the `virtualenv` command if not.

Install [Python 3](https://www.python.org/download/releases/3.0/)
```sh
# list possible python versions
pyenv install --list
# install a python version
pyenv install 3.9.5

# create a new virtualenv
pyenv virtualenv 3.9.5 python3
# activate a virtualenv
pyenv activate python3
# deactivate a virtualenv
pyenv deactivate

# path to python executable
pyenv which python
# list available virtualenvs
pyenv virtualenvs

# delete existing virtualenv
pyenv uninstall python3
```

## Generate a requirements.txt file

```sh
# create new isolated virtualenv
pyenv virtualenv 3.9.5 NAME
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

- [Docker blog post series](https://www.docker.com/blog/tag/python-env-series/)

test