# Linux (Debian)

## Packages

### Upgrade packages

```sh
sudo apt update && sudo apt upgrade && sudo apt autoremove
```

### Upgrade Debian release

[Official guide](https://wiki.debian.org/DebianUpgrade)

```sh
old_debian_version=bullseye
new_debian_version=bookworm

cat /etc/apt/sources.list /etc/apt/sources.list.d/* | grep $old_debian_version

sed -i "s/$old_debian_version/$new_debian_version/g" /etc/apt/sources.list
find /etc/apt/sources.list.d/ -type f | xargs sudo sed -i "s/$old_debian_version/$new_debian_version/g"

cat /etc/apt/sources.list /etc/apt/sources.list.d/* | grep $new_debian_version

sudo apt-get clean
sudo apt-get update
sudo apt-get upgrade        # and go grab a coffee
sudo apt-get full-upgrade   # and go grab a second coffee

sudo apt-get autoremove
sudo shutdown -r now
```

### dpkg

```sh
dpkg -l                               # list all packages installed
dpkg --get-selections "*wget*"        # list installed packages with 'wget' in their name
dpkg -L wget                          # list files installed in the wget package
dpkg -p wget                          # show information about an installed package
dpkg -I webfs_1.21+ds1-8_amd64.deb    # show information about a package file
dpkg -c webfs_1.21+ds1-8_amd64.deb    # list files in a package file
dpkg -S /etc/init/networking.conf     # show what package owns /etc/init/networking.conf
dpkg -s wget                          # show the status of a package
dpkg -V package                       # verify the installed package's integrity
sudo dpkg -i foobar.deb	              # installing or upgrading the foobar package
sudo dpkg -r package                  # remove all of an installed package except for its configuration files
sudo dpkg -P package                  # remove all of an installed package, including its configuration files
```

### apt

```sh
[apt|apt-get] update
apt list --upgradable 
[apt|apt-get] upgrade
[apt|apt-get] autoremove
[apt|apt-cache] search metapackage    # see all metapackages
[apt|apt-cache] search -n wget        # search for packages called 'wget'
[apt|apt-cache] show wget             # show package info
[apt|apt-cache] [depends|rdepends] wget   # show dependencies / reverse deps respectively
```

### Add an additional PPA for newer or extra packages

```sh
# https://launchpad.net/~git-core/+archive/ubuntu/ppa
echo '''
deb http://ppa.launchpad.net/git-core/ppa/ubuntu/ xenial main
# deb-src http://ppa.launchpad.net/git-core/ppa/ubuntu/ xenial main
''' | sudo tee -a /etc/apt/sources.list.d/git-core-ubuntu-ppa-xenial.list

curl https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xe1dd270288b4e6030699e45fa1715d88e1df1f24 | sudo apt-key add

sudo apt-get update && sudo apt-get upgrade
```

### Install and hold on specific package version

```sh
apt-get install -y kubeadm=1.21.1-00 kubelet=1.21.1-00 kubectl=1.21.1-00
apt-mark hold kubelet kubeadm kubectl
```

## Filesystem

- [Filesystem Hierarchy Standard](https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.pdf)

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

### Extract files

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

### Increase max number of watched files

```sh
cat /proc/sys/fs/inotify/max_user_watches

sudo vi /etc/sysctl.conf
# add at the end of file:
#   fs.inotify.max_user_watches=524288

sudo sysctl -p
```

## Processes

### Inspect running services 

```sh
systemctl list-units -t service --state running
# check particular service 
sudo systemctl status docker.service
# go through logs, pg up / down ;)
sudo journalctl -u docker.service | less
```

### Control processes

```sh
top
ps aux
ps axjf           # show process tree
ps -eo pid,comm   # list all processes in 'pid comm' format
pgrep -a -u r2    # list all processes by user 'r2'
pgrep keybase | xargs sudo kill -9    # kill all processes matching 'keybase'
```

### ulimit

```sh
man limits.conf
cat /etc/security/limits.conf | less
ulimit -a [-S|-H]                       # list all Soft / Hard limits
ulimit [LIMIT] [-S|-H] [NEW_LIMIT]      # get / set new limit
```

### Identify shared memory segments

```sh
ipcs
ipcs -p                                 # outputs creator / last operator PIDs
ps aux | grep -wE -e "2753" -e "851"    # see info on processes
```

## Signals

```sh
for i in {1..31}; do; echo "$i: $(kill -l $i)"; done
kill -9 PID
kill -9 $(pgrep -u r2)      # kill all processes by user r2
killall -9 PROCESS_NAME
```

## Containerization

### Namespaces

- [namespaces(7) — Linux manual page](https://www.man7.org/linux/man-pages/man1/unshare.1.html)

```sh
lsns
ls -l /proc/[PID]/ns
readlink /proc/[PID]/ns/pid

# create new namespace
unshare -pf --mount-proc bash
```

### Overlay filesystems

### Cgroups

## Miscellanea

### Get current release version

```sh
cat /etc/os-release | sed -nE "s/VERSION=\"(.*)\"/\1/p"
```

### Get Ubuntu's base Debian version

```sh
ubuntu_version=xenial
curl https://git.launchpad.net/ubuntu/+source/base-files/plain/etc/debian_version?h=ubuntu/$ubuntu_version
```

### Install a keyring file

```sh
# with gpg
sudo gpg --homedir /tmp --no-default-keyring --keyring /etc/apt/keyrings/debian.gpg --keyserver keyserver.ubuntu.com --recv-keys 0E98404D386FA1D9 6ED0E7B82643E131 F8D2585B8783D481
sudo gpg --homedir /tmp --no-default-keyring --keyring /etc/apt/keyrings/debian-security.gpg --keyserver keyserver.ubuntu.com --recv-keys 54404762BBB6E853 BDE6D2B9216EC7A8

# or get public signing key (.asc / .key / .pub file) from some trusted source
# and unpack it into either /etc/apt/keyrings or /usr/share/keyrings
curl -sSL https://someurl.com/path/to/KEYNAME.[asc|key] | sudo gpg --dearmor -o /usr/share/keyrings/KEYNAME.gpg

# then in a /etc/apt/sources.list.d file:
# deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.33/deb/ stable main
```

### Add user to sudoers

```sh
echo 'username ALL=(ALL) ALL' > /etc/sudoers.d/username
sudo chmod 440 /etc/sudoers.d/username
```

### Modify PATH env variable

```sh
PATH=$PATH:/path/to/bin
printenv
```
