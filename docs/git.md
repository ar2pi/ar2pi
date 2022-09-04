# Git

## Set a global user for authoring commits

```sh
git config --global user.name "YOUR_NAME"
git config --global user.email "your_email@example.com"
```

## Use a different user for a specific git project

To use a different user than the one configured globally for authoring commits, run the following in the project folder:
```sh
git config --local user.name "YOUR_NAME"
git config --local user.email "your_email@example.com"
```

## Generate a ssh key

Follow the instructions in [GitHub Docs - Generating a new SSH key](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key).

## Get public key fingerprint

```bash
ssh-keygen -l -E sha256 -f ~/.ssh/id_ed25519
# or
ssh-keygen -l -E md5 -f ~/.ssh/id_rsa
```

## Use distinct ssh keys between hosts

Add the following in `~/.ssh/config`, adapting to your specific setup:
```text
Host github.com
  HostName github.com
  User git
  PreferredAuthentications publickey
  IdentityFile ~/.ssh/[KEY_1]

Host gitlab.com
  HostName gitlab.com
  User git
  PreferredAuthentications publickey
  IdentityFile ~/.ssh/[KEY_2]
```

For more options run [man ssh_config](https://linux.die.net/man/5/ssh_config).

> In case you need to create `~/.ssh/config` ensure proper file permissions are set with `chmod 600 ~/.ssh/config`

## Use a gpg key to sign git commits

### Generate a gpg key using YubiKey

Generate Signature, Encryption and Authentication keys, with your YubiKey plugged in:
```sh
# force the use of RSA 4096 keys
gpg --edit-card
gpg/card> admin
gpg/card> key-attr
# follow prompts and repeat for Signature, Encryption and Authentication keys

# generate keys
gpg --edit-card
gpg/card> admin
gpg/card> generate
# follow prompts and repeat for Signature, Encryption and Authentication keys
```

Tested with [YubiKey 5C NFC](https://www.yubico.com/co/product/yubikey-5c-nfc/)

### Instruct git to use gpg key

```sh
# list keys, key id is what comes after rsa4096/
gpg --list-secret-keys --keyid-format=long

# configure git to sign commits with your gpg key
git config --global user.signingKey [KEY_ID]
git config --global commit.gpgsign true
git config --global gpg.program gpg

# export key to add to your GitHub profile or whatever
gpg --armor --export [YOUR_EMAIL]
```

### Set touch flags

```sh
sudo apt install yubikey-manager
# see possible options
ykman openpgp keys set-touch -h
# turn flags on
ykman openpgp keys set-touch sig cached
ykman openpgp keys set-touch enc cached
ykman openpgp keys set-touch aut cached
```

### Set up another workstation

```sh
# export the GPG key from source workstation
gpg --output public.pgp --armor --export [KEY_ID]
# import the GPG key in target workstation
gpg --import public.pgp
```
