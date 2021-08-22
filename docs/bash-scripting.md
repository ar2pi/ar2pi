# Bash scripting

## .zshrc

Gist: [https://gist.github.com/ar2pi/41d1d0645d6437d7b69b6e7c64e88d8e](https://gist.github.com/ar2pi/41d1d0645d6437d7b69b6e7c64e88d8e)

## Snippets

**`#!/usr/bin/env {zsh,bash}`**

### Log function

```bash
#!/usr/bin/env bash

#
# A simple bash function to output messages
#
# Usage: 
#   out "Hello world!"
#   out warn "A warning message"
#   out error "An error message"
#

function out () {
    local RST="\033[0m"
    local YELLOW="\033[0;33m"
    local MAGENTA="\033[0;35m"
    local CYAN="\033[0;36m"
    local LIGHT_YELLOW="\033[0;93m"
    local LIGHT_MAGENTA="\033[0;95m"
    local LIGHT_CYAN="\033[0;96m"

    local msg=$1
    local color_1=$CYAN
    local color_2=$LIGHT_CYAN

    if [[ $1 == "warn" ]]; then
        msg=$2
        color_1=$YELLOW
        color_2=$LIGHT_YELLOW
    elif [[ $1 == "error" ]]; then
        msg=$2
        color_1=$MAGENTA
        color_2=$LIGHT_MAGENTA
    fi

    echo -e "${color_1}❯${color_2} $msg${RST}"
}
```

Gist: [https://gist.github.com/ar2pi/b0c229afe9cd5f7d02645c8c62b5e989](https://gist.github.com/ar2pi/b0c229afe9cd5f7d02645c8c62b5e989)

### Autoload .nvmrc

```zsh
#!/usr/bin/env zsh

#
# Call `nvm use` automatically in a directory with a .nvmrc file, silently
#
# Usage:
#   Add this to your ~/.zshrc
#
# Taken from https://github.com/nvm-sh/nvm#zsh 
# Difference being that this one is less verbose (like pyenv or goenv)
#

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [[ -n $nvmrc_path ]]; then
    local nvmrc_node_version=$(nvm version $(cat ${nvmrc_path}))

    if [[ $nvmrc_node_version = "N/A" ]]; then
      nvm install
    elif [[ $nvmrc_node_version != $node_version ]]; then
      nvm use > /dev/null
    fi
  elif [[ $node_version != "$(nvm version default)" ]]; then
    nvm use default > /dev/null
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
```

Gist: [https://gist.github.com/ar2pi/02d14fbc6e987056ae0efd301faf64de](https://gist.github.com/ar2pi/02d14fbc6e987056ae0efd301faf64de)

### Adblock.sh

```bash
#!/usr/bin/env bash

#
# This script will append additional entries (from http://winhelp2002.mvps.org/hosts.txt) in /etc/hosts file.
# run: "adblock" 
#
# Notes:
#   - A backup is created as `hosts.bk` in current working directory.
#

cp /etc/hosts hosts.bk
sudo sh -c "curl -sSL -o - http://winhelp2002.mvps.org/hosts.txt >> /etc/hosts"
```

Gist: [https://gist.github.com/ar2pi/25d7ffc31cb1695bef557556ded182fe](https://gist.github.com/ar2pi/25d7ffc31cb1695bef557556ded182fe)