# Network

## Show internal IP address

#### On Mac
```sh
# IPv4
ifconfig en0 | grep -oE "inet ([^ ]+)" | cut -d " " -f 2
# IPv6
ifconfig en0 | grep -oE "inet6 ([^ ]+)" | cut -d " " -f 2
```
#### On Linux (Debian)
```sh
# IPv4
ip addr show enp4s0 | grep -oE "inet ([^/]+)" | cut -d " " -f 2
# IPv6
ip addr show enp4s0 | grep -oE "inet6 ([^/]+)" | cut -d " " -f 2
```

## Show public IP address

```sh
curl ifconfig.me/ip
```
