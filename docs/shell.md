# Shell

## .zshrc

Gist: [https://gist.github.com/ar2pi/41d1d0645d6437d7b69b6e7c64e88d8e](https://gist.github.com/ar2pi/41d1d0645d6437d7b69b6e7c64e88d8e)

## Snippets

**`#!/usr/bin/env {zsh,bash}`**

### Get current script directory and filename

```bash
CURRENT_SCRIPT_DIR=$(dirname ${BASH_SOURCE[0]})               # Relative path
CURRENT_SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)  # Absolute path
CURRENT_SCRIPT_FILE=$(basename ${BASH_SOURCE[0]})
```

### Default variable value

```bash
${var:-"default"}
```

See [POSIX spec](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02)

### Bash strict mode

```bash
#!bin/bash

set -e           # exit on error
set -u           # error on unitialized variable
set -o pipefail  # error out on pipes

# also
set -x           # print out commands
```

See [Set Builtin bash reference manual](https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html)

### Hash tables (associative arrays) in linux shell scripts

#### bash

**bash v3**

```bash
function key_val () {
    case $1 in
        "foo") echo "bar";;
        "baz") echo "qux";;
        *) echo "default";;
    esac
}

for key in "foo" "baz"; do
    echo "$key: $(key_val $key)"
done
```

**bash v4**

```bash
declare -A arr
arr=([foo]=bar [baz]=qux)

for key in ${!arr[@]}; do 
    echo "$key: ${arr[$key]}"
done
```

#### zsh

```zsh
declare -A arr
arr=([foo]=bar [baz]=qux)

for key value in ${(kv)arr}; do 
    echo "$key: $value"
done
```

#### Hacky cross-shell alternative

```sh
#!/bin/bash

arr=(
    "key value"
    "foo bar"
)

for item in "${arr[@]}"; do
    key=$(echo $item | cut -d " " -f 1)
    value=$(echo $item | cut -d " " -f 2)
    
    echo "$key: $value"
done
```

[Gist](https://gist.github.com/ar2pi/99dbcbbd023867aeee089bf65014cd20)

### Parse arguments

```bash
# single argument flag
if [[ ! -z ${1+_} && ($1 = "-v" || $1 = "--verbose") ]]; then
    is_verbose=1
fi

# single argument with value
if [[ ! -z ${1+_} && ($1 = "-n" || $1 = "--name") ]]; then
    name=$2
fi

# multiple args, with positional support
positional_args=()
while [[ $# -gt 0 ]]; do
    case $1 in
        "-n"|"--name") name=$2; shift;;
        "-v"|"--verbose") is_verbose=1;;
        *) positional_args+=($1); shift;;
    esac
    shift
done
```

#### Bash command line argument parser

```bash
#!/usr/bin/env bash

#
# An over-engineered bash argument parser
# Inspired from *args and **kwargs in Python
#
# Usage:
#   parse_args "$@"
#
# Examples:
#   script.sh 10 20
#     args: [10, 20]
#     kwargs: []
#   script.sh --foo bar --baz qux 10 20
#     args: [10, 20]
#     kwargs: [foo: bar, baz: qux]
#   script.sh -x 3 -y 2 -z -- 10 20
#     args: [10, 20]
#     kwargs: [x: 3, y: 2, z: 1]
#

declare -a args
declare -A kwargs

function is_value () {
    if [[ $(echo $1 | grep -cE "^-") = 0 ]]; then
        return 0
    fi
    return 1
}

function parse_args () {
    local arg
    local value

    while [[ $# -gt 0 ]]; do
        if [[ $1 = "--" ]]; then
            shift; continue
        elif $(is_value $1); then
            arg=$1
        else
            arg=$(echo $1 | sed -nE "s/--?(.*)/\1/p")
        fi

        if [[ ! -z ${2+_} ]] && $(is_value $2) && ! $(is_value $1); then
            kwargs[$arg]=$2
            shift
        elif ! $(is_value $1); then
            kwargs[$arg]=1
        else
            args+=($arg)
        fi
        shift
    done
}
```

[Gist](https://gist.github.com/ar2pi/0d61686e9c16671a39197139588e94c1)

### Load other bash files

```bash
[[ -f /path/to/script.sh ]] && . /path/to/script.sh
```

```bash
#!/usr/bin/env bash

#
# A simple bash script to execute all adjacent scripts
#
# Usage:
#   source /path/to/all.sh
#   OR
#   . /path/to/all.sh
#
# Options:
#   -v|--verbose: verbose output
#

function main () {
    local CURRENT_SCRIPT_DIR=$(dirname ${BASH_SOURCE[0]})
    local CURRENT_SCRIPT_FILE=$(basename ${BASH_SOURCE[0]})
    local modules=$(ls -1 -I $CURRENT_SCRIPT_FILE $CURRENT_SCRIPT_DIR)
    local is_verbose=$([[ ! -z ${1+_} && ($1 = "-v" || $1 = "--verbose") ]] && echo "1" || echo "0")

    for module in $modules; do
        if [[ -f $CURRENT_SCRIPT_DIR/$module ]]; then
            . $CURRENT_SCRIPT_DIR/$module
            if [[ $is_verbose = 1 ]]; then
                echo "Loaded $CURRENT_SCRIPT_DIR/$module"
            fi
        fi
    done
}

main "$@"
```

[Gist](https://gist.github.com/ar2pi/d19869c5ba2b2b42601124939593ae89)

### Log function

```bash
#!/usr/bin/env bash

#
# A simple bash function to output colorful messages
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

[Gist](https://gist.github.com/ar2pi/b0c229afe9cd5f7d02645c8c62b5e989)

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

[Gist](https://gist.github.com/ar2pi/02d14fbc6e987056ae0efd301faf64de)

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

[Gist](https://gist.github.com/ar2pi/25d7ffc31cb1695bef557556ded182fe)
