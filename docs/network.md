# Network

## Show internal IP address

### IPv4
#### On Mac
```sh
ifconfig en0 | grep -oE "inet ([^ ]+)" | cut -d " " -f 2
```
#### On Linux (Debian)
```sh
ip addr show enp4s0 | grep -oE "inet ([^/]+)" | cut -d " " -f 2
```

### IPv6
#### On Mac
```sh
ifconfig en0 | grep -oE "inet6 ([^ ]+)" | cut -d " " -f 2
```
#### On Linux (Debian)
```sh
ip addr show enp4s0 | grep -oE "inet6 ([^/]+)" | cut -d " " -f 2
```

## Show public IP address

```sh
curl ifconfig.me/ip
```
