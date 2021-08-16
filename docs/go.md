# Go

## Install

[golang.org/doc/install](https://golang.org/doc/install)

---
#### On Mac
```sh
brew install golang

cat <<EOF >> ~/.zshrc 
# go
export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin
export PATH=$PATH:$GOBIN
EOF
```
#### On Linux (Debian)
```sh
curl -sSL -O https://golang.org/dl/go1.17.linux-amd64.tar.gz
rm -rvf /usr/local/go
sudo tar -C /usr/local -xzf go1.17.linux-amd64.tar.gz
rm -rvf go1.17.linux-amd64.tar.gz

cat <<EOF >> ~/.zshrc 
# go
export GOBIN=/usr/local/go/bin
export PATH=$PATH:$GOBIN
EOF
```
---

```sh
source ~/.zshrc 
```
