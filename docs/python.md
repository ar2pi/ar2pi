# Python

## Local setup

Install [pyenv](https://github.com/pyenv/pyenv) to switch between Python versions.  
Use `python3 -m venv .venv` to create a local virtual environment.  
In zsh, install [zsh-autoswitch-virtualenv](https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv) to autoswitch between local venvs.  
To manage local project dependencies use [poetry](https://python-poetry.org).

### Use a specific [Python 3](https://www.python.org/downloads/) version

```sh
pyenv install 3.13        # install latest minor python version
pyenv local 3.13          # use newly installed python version and generates .python-version file

python3 -m venv .venv     # create a virtualenv
# or `mkvenv` with zsh-autoswitch-virtualenv
```

Other useful `pyenv` commands:
```sh
pyenv versions      # list installed python versions
pyenv version-name  # show current python version
pyenv which python  # show path to python executable

pyenv uninstall 3.13.4  # remove python version, needs to be specific
```

### Configure [Poetry](https://python-poetry.org) for dependency management

```sh
poetry config virtualenvs.create true --local
poetry init
```

To use poetry only for dependency management in `pyproject.toml` add:
```toml
[tool.poetry]
package-mode = false
```

To add some deps:
```sh
poetry add mkdocs
poetry add -D black isort   # dev deps
```

### Generate a `.python-version` file

Shouldn't be needed after running `pyenv local ...` but in any other case:

```sh
echo $(pyenv version-name) > .python-version
```

`.python-version` is then used by `pyenv` to automatically switch to correct python version when navigating into the project's folder.

### Generate a `requirements.txt` file

Shouldn't be needed when using poetry but in any other case:

```sh
pyenv shell 3.13                    # use specific python version
pip install [DEPENDENCY_1] [...]    # install dependencies
pip freeze > requirements.txt       # freeze requirements
```

#### Install dependencies from a requirements.txt file

```sh
pip install -r requirements.txt
```

## Containerized Python development

- [run-python-script](https://github.com/ar2pi/run-python-script)
- [Read the Docker blog post series](https://www.docker.com/blog/tag/python-env-series/)

## Docs

- [The Python Language Reference](https://docs.python.org/3/reference/index.html)
- [The Python Standard Library](https://docs.python.org/3/library/index.html)

## Package registry

- [PyPi](https://pypi.org/)

## Snippets

**`#!/usr/bin/env python`**

### Consult object help

```python
help(set)
```

### Parse arguments

```python
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('-v', '--verbose', action='store_true')
parser.add_argument('-i', '--requests-interval', type=float, default=5)
args = parser.parse_args()

print(args.verbose, args.requests_interval)
```

Reference:
- [https://docs.python.org/3/howto/argparse.html](https://docs.python.org/3/howto/argparse.html)
- [https://docs.python.org/3/library/argparse.html](https://docs.python.org/3/library/argparse.html)

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

### Unpacking zen

#### Remove list duplicates

```python
a = [1, 1, 2, 2, 3, 3]
*a, = {*a} # a = [1, 2, 3]
```

#### Overwrite dictionary values

```python
a = {'foo': 'bar', 'baz': 'qux'}
b = {'foo': 'quux', 'quuz': 'courge'}
b = {**a, **b} # b = {'foo': 'quux', 'baz': 'qux', 'quuz': 'courge'}
```

#### Nested unpacking

```python
a, *b, (c, d, e) = [1, 2, 3, 'XYZ']
# a = 1, b = [2, 3], c = 'X', d = 'Y', e = 'Z'
```
