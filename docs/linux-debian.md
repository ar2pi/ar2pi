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

## Filesystem

[Filesystem Hierarchy Standard](https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.pdf)

### Show directories size and last modified date

```sh
sudo du --max-depth=1 -ax --si --time /
```
Note that `-x` will exclude `/dev`, `/proc`, `/run`, `sys` since these are pseudo-filesystems which exist in memory only.

## Processes

### List processes

```sh
ps aux
pgrep [-a|-l] -u r2 # list all processes by user 'r2'
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
killall -9 PROCESS_NAME
```

## dpkg

```sh
dpkg -l   # List all packages installed
dpkg --get-selections "*wget*"  # List installed packages with 'wget' in their name
dpkg -L wget	# List files installed in the wget package
dpkg -p wget	# Show information about an installed package
dpkg -I webfs_1.21+ds1-8_amd64.deb	# Show information about a package file
dpkg -c webfs_1.21+ds1-8_amd64.deb	# List files in a package file
dpkg -S /etc/init/networking.conf	# Show what package owns /etc/init/networking.conf
dpkg -s wget	# Show the status of a package
dpkg -V package	# Verify the installed package's integrity
sudo dpkg -i foobar.deb	# installing or upgrading the foobar package
sudo dpkg -r package		# remove all of an installed package except for its configuration files
sudo dpkg -P package	# remove all of an installed package, including its configuration files
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