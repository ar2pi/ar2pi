# Linux (Debian)

## Get current release version

```sh
cat /etc/os-release | sed -nE "s/VERSION=\"(.*)\"/\1/p"
```

## Get Ubuntu base debian version

```sh
ubuntu_version=xenial
curl https://git.launchpad.net/ubuntu/+source/base-files/plain/etc/debian_version?h=ubuntu/$ubuntu_version
```

## Add user to sudoers

```sh
echo 'username ALL=(ALL) ALL' > /etc/sudoers.d/username
sudo chmod 440 /etc/sudoers.d/username
```

## Modify PATH env variable

```sh
PATH=$PATH:/path/to/bin
```

## Adding an additional PPA for newer or extra packages

```sh
# https://launchpad.net/~git-core/+archive/ubuntu/ppa
echo '''
deb http://ppa.launchpad.net/git-core/ppa/ubuntu/ xenial main
# deb-src http://ppa.launchpad.net/git-core/ppa/ubuntu/ xenial main
''' | sudo tee -a /etc/apt/sources.list.d/git-core-ubuntu-ppa-xenial.list

curl https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xe1dd270288b4e6030699e45fa1715d88e1df1f24 | sudo apt-key add

sudo apt-get update && sudo apt-get upgrade
```
