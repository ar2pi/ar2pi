# Network

## Show internal IP address

IPv4
```sh
ifconfig en0 | grep -oE "inet ([^ ]+)" | cut -d " " -f 2
```

IPv6
```sh
ifconfig en0 | grep -oE "inet6 ([^ ]+)" | cut -d " " -f 2
```

## Show public IP address

```sh
curl ifconfig.me/ip
```
