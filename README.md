<p align="center">
  <img width="575" height="auto" src="./Fox.png" alt="Fox">
</p>

# Sly
A CLI tool utilizing plain Bash functions.

> ⚠️ **Important!** Sly is only tested on Linux, with `bash` and `zsh`

## Install

```bash
$ curl -Lo- git.io/sly-install | bash
```

## Slyfile

Create a `Slyfile` in the current directory:

```bash
$ sly --init
```

Add functions to the `Slyfile`. They may contain any Bash code. Functions starting with an underscore (e.g. `_certs`) are considered "private" and won't be shown using `sly --list` to keep that tidy.

### Simple example

> Note: either the shorthand (`foo() {}`) or the long notation (`function foo {}`) can be used to define functions

```bash
example() {
  width=${1-12}
  length=${2-5}
  area=$((width * length))
  echo "Area is: $area (${width} x ${length})"
  [ "$width" == "$length" ] && echo "It's a square"
  echo "And the current directory is: $(pwd)"
  echo "Calling 'uname -a':"
  uname -a
}
```

To run this example, try these commands for different output:
- `sly example`
- `sly example 2 5`
- `sly example 3 3`

> Remember, it's just plain bash. No magic.

### A real-world example

This is a set of functions used for a **Django** project running on **Docker**:

```bash
#!/usr/bin/env bash
#
### Slyfile - used by sly
### https://github.com/richarddewit/sly

# Variables/aliases
dc="docker-compose"
manage="$dc exec app python manage.py"

start() {
  # Start containers
  $dc up -d --build
}

stop() {
  # Stop containers
  $dc down
}

restart() {
  # Combine functions
  stop
  start
}

logs() {
  # Watch logs
  # Run `sly logs` to log all containers, `sly logs app` to only log
  # the `app` container
  if [ -n "$1" ]; then
    $dc logs -f "$1"
  else
    $dc logs -f
  fi
}

python() {
  # Run interactive shell inside `app` container
  $manage shell
}

manage() {
  # Run `manage.py` commands in `app` container
  # Use `$@` to pass along all arguments of the function
  $manage "$@"
}

m() {
  # Define custom shortcut functions
  # Now you can run `sly m makemigrations`
  $manage "$@"
}

test() {
  # Run tests in `app` container
  $manage test
}

psql() {
  # Run postgres shell in `db` container
  $dc exec db psql -U postgres
}

sync() {
  # Synchronise the lock- and requirements file
  # with the installed packages
  pipenv lock
  pipenv lock --requirements > requirements.txt
}

```
