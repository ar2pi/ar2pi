# Networking

## Show internal IP address

---
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
---

## Show default gateway

---
#### On Mac
```sh
netstat -nr
```
#### On Linux (Debian)
```sh
ip route show default
```
---

## Show public IP address

```sh
curl ifconfig.me/ip
```

## Show DNS records

```sh
dig docs.ar2pi.net +nostats +nocomments +nocmd
```

## netcat 

### TCP
```sh
# sh 1
nc -l 3456
# sh 2
nc localhost 3456
# type in 'hello world'
```
Open http://localhost:3456 and look at request headers sent to `sh 1`

### HTTP w/ netcat
```sh
printf 'GET / HTTP/1.1\r\nHost: ar2pi.github.com\r\n\r\n' | nc -N ar2pi.github.com 80 > response.html
```

### Redirect through netcat
```sh
printf 'HTTP/1.1 302 Moved\r\nLocation: https://docs.ar2pi.net/' | nc -N -l 3456
```
Open [http://localhost:3456](http://localhost:3456) and witness redirect

## tcpdump

```sh
# sh 1
sudo tcpdump -n port 80
# sh 2
printf 'GET / HTTP/1.1\r\nHost: ar2pi.github.com\r\n\r\n' | nc -N ar2pi.github.com 80
```

## traceroute

```sh
traceroute -T -p 80 ar2pi.github.com
```
