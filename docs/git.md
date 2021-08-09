# Git

## Generate a ssh key

Follow the instructions in [GitHub Docs - Generating a new SSH key](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key).

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
