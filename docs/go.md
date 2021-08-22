# Go

## Install

[golang.org/doc/install](https://golang.org/doc/install)  
[goenv](https://github.com/syndbg/goenv)  
[bingo](https://github.com/bwplotka/bingo)

---
#### On Mac
```sh
brew install goenv # seems outdated, no latest go versions listed
```
#### On Linux (Debian)
```sh
git clone https://github.com/syndbg/goenv.git ~/.goenv
```
---

```sh
cat <<EOF >> ~/.zshrc 
# goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="$PATH:$GOENV_ROOT/bin"
eval "$(goenv init -)"
export PATH="$PATH:$GOROOT/bin"
export PATH="$PATH:$GOPATH/bin"
EOF

source ~/.zshrc 
```

## Configure a Go env

```sh
goenv install --list # list go versions
goenv install 1.17.0 # install a go version
goenv global 1.17.0 # set default global go version
goenv local 1.17.0 # set project version in .go-version file
```

Other useful `goenv` commands:
```sh
goenv version # show current go version
goenv versions # show installed go versions
```

## Docs

- [The Go Programming Language Specification](https://golang.org/ref/spec)
- [The Go Standard Library](https://pkg.go.dev/std)

## Package registry

- [Go Packages](https://pkg.go.dev/)
