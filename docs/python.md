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
pyenv virtualenv 3.9.6 [VENV_NAME] # create a new virtualenv
pip install [DEPENDENCY_1] [...] # install dependencies
pip freeze > requirements.txt # freeze requirements
```

## Install dependencies from a requirements.txt file

```sh
pip install -r requirements.txt
```

## Docs

- [The Python Language Reference](https://docs.python.org/3/reference/index.html)
- [The Python Standard Library](https://docs.python.org/3/library/index.html)

## Containerized Python development

- [Read the Docker blog post series](https://www.docker.com/blog/tag/python-env-series/)

## Snippets

### Performance counter 

[time.perf_counter()](https://docs.python.org/3/library/time.html#time.perf_counter)

```python
import time
start = time.perf_counter()
# ...
end = time.perf_counter()
print('timing: {time}'.format(time=(end - start)))
```

### Reference count

```python
import ctypes
def ref_count(address):
    return ctypes.c_long.from_address(address).value
```

### Interning 

```python
a = 10
b = int('1010', 2)
print(hex(id(a)))
print(hex(id(b)))
a is b # True, in [-5, 256]

a = 500
b = 500
a is b # False
```

String interning: don't do this unless optimization is needed
```python
import sys
a = 'foo'
b = 'foo'
a is b # True, looks like an identifier so gets interned... but don't count on it

a = 'foo bar'
b = 'foo bar'
a is b # False

a = sys.intern('foo bar')
b = sys.intern('foo bar')
a is b # True
```

### Peephole 

```python
def my_func():
    a = 24 * 60
    b = 'foo'
    c = 'foo' * 2
    d = ['foo', 'bar']
    e = ('foo', 'bar')
    f = {'foo', 'bar'}

print(my_func.__code__.co_consts) 
# (None, 24, 60, 'foo', 2, 'bar', 1440, 'foofoo', ('foo', 'bar'))
```
