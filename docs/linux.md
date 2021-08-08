# Linux

## Add user to sudoers

```sh
echo 'username ALL=(ALL) ALL' > /etc/sudoers.d/username
sudo chmod 440 /etc/sudoers.d/username
```

## Modify PATH env variable

```sh
PATH=$PATH:/path/to/bin
```
