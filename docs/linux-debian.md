# Linux (Debian)

## Get current release version

```sh
cat /etc/os-release | sed -nE "s/VERSION=\"(.*)\"/\1/p"
```

## Get Ubuntu's base Debian version

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

## Upgrade packages

```sh
sudo apt update && sudo apt upgrade && sudo apt autoremove
```

## Add an additional PPA for newer or extra packages

```sh
# https://launchpad.net/~git-core/+archive/ubuntu/ppa
echo '''
deb http://ppa.launchpad.net/git-core/ppa/ubuntu/ xenial main
# deb-src http://ppa.launchpad.net/git-core/ppa/ubuntu/ xenial main
''' | sudo tee -a /etc/apt/sources.list.d/git-core-ubuntu-ppa-xenial.list

curl https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xe1dd270288b4e6030699e45fa1715d88e1df1f24 | sudo apt-key add

sudo apt-get update && sudo apt-get upgrade
```

## Install and hold on specific package version

```sh
apt-get install -y kubeadm=1.21.1-00 kubelet=1.21.1-00 kubectl=1.21.1-00
apt-mark hold kubelet kubeadm kubectl
```

## Increase max number of watched files

```sh
cat /proc/sys/fs/inotify/max_user_watches

sudo vi /etc/sysctl.conf
# add at the end of file:
#   fs.inotify.max_user_watches=524288

sudo sysctl -p
```

## Filesystem

[Filesystem Hierarchy Standard](https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.pdf)

### Show directories size and last modified date

```sh
sudo du --max-depth=1 -ax --si --time /
```
Note that `-x` will exclude `/dev`, `/proc`, `/run`, `sys` since these are pseudo-filesystems which exist in memory only.

### Find files

```sh
find /usr -type d -name "icons"
ls ~/Downloads | grep .mp3
find ~/ -maxdepth 2 -type f -name "*.mp3"
```

## Extract files

```sh
tar -xvf 02-Flat-Remix-Blue-Dark_20210620.tar.xz -C /usr/share/icons/
```

### List open files

```sh
sudo lsof -a -u r2 -c spotify -p ^9365 -d 0-$(ulimit -S -n) +D /usr | grep -E "REG|DIR" | less
# get all files / directories under /usr open with an actual file descriptor number by user r2, comand `spotify`, except process 9365
```

FD mode
```
r for read access;
w for write access;
u for read and write access;
```

TYPE
```
REG for a directory;
DIR for a regular file;
```

## Processes

### List processes

```sh
top
ps aux
ps axjf # show process tree
pgrep -a -u r2 # list all processes by user 'r2'
```

### ulimit

```sh
man limits.conf
cat /etc/security/limits.conf | less
ulimit -a [-S|-H] # list all Soft / Hard limits
ulimit [LIMIT] [-S|-H] [NEW_LIMIT] # get / set new limit
```

### Identify shared memory segments

```sh
ipcs
ipcs -p # outputs creator / last operator PIDs
ps aux | grep -wE -e "2753" -e "851" # see info on processes
```

## Signals

```sh
for i in {1..31}; do; echo "$i: $(kill -l $i)"; done
kill -9 PID
kill -9 $(pgrep -u r2) # kill all processes by user r2
killall -9 PROCESS_NAME
```

## dpkg

```sh
dpkg -l # list all packages installed
dpkg --get-selections "*wget*" # list installed packages with 'wget' in their name
dpkg -L wget # list files installed in the wget package
dpkg -p wget # show information about an installed package
dpkg -I webfs_1.21+ds1-8_amd64.deb # show information about a package file
dpkg -c webfs_1.21+ds1-8_amd64.deb # list files in a package file
dpkg -S /etc/init/networking.conf # show what package owns /etc/init/networking.conf
dpkg -s wget # show the status of a package
dpkg -V package # verify the installed package's integrity
sudo dpkg -i foobar.deb	# installing or upgrading the foobar package
sudo dpkg -r package # remove all of an installed package except for its configuration files
sudo dpkg -P package # remove all of an installed package, including its configuration files
```

## apt

```sh
[apt|apt-get] update
apt list --upgradable 
[apt|apt-get] upgrade
[apt|apt-get] autoremove
[apt|apt-cache] search metapackage # see all metapackages
[apt|apt-cache] search -n wget # search for packages called 'wget'
[apt|apt-cache] show wget # show package info
[apt|apt-cache] [depends|rdepends] wget # show dependencies / reverse deps respectively
```
