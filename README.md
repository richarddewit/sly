![Fox](./Fox.png)

# Sly
A CLI tool utilizing plain Bash functions.

> ⚠️ **Important!** Sly is only tested on Linux

## Install

```bash
curl -Lo- git.io/sly-install | bash
```

## Slyfile

Create a `Slyfile` somewhere you need it:

```bash
sly --init
```

Add functions to the `Slyfile`. They may contain any Bash code.

### Example

> Note: either the shorthand (`foo() {}`) or the long notation (`function foo {}`) can be used to define functions

```bash
ping_home() {
  ping -c ${1-5} 127.0.0.1
  screenfetch
}
```

Then run it with `sly ping_home 10` to do 10 pings to localhost and run `screenfetch` afterwards. Or run without arguments (`sly ping_home`) to do the default 5 pings instead of 10.

### A more real-world example

This is a sample of functions used for a **Django** project running on **Docker**:

```bash
### Slyfile - used by sly
### https://github.com/richarddewit/sly

# Variables/aliases
dc="docker-compose"
manage="$dc exec app python manage.py"

start() {
  # Start containers and watch logs
  $dc up -d
  $dc logs -f
}

stop() {
  # Stop containers
  $dc down
}

logs() {
  # Watch logs
  # `sly logs` to log all containers, `sly logs app` to only log the `app` container
  $dc logs -f $1
}

python() {
  # Run `python` shell inside `app` container
  $dc exec app python
}

manage() {
  # Run `manage.py` commands in `app` container
  $manage $@
}

test() {
  # Run tests in `app` container
  $manage test
}
```
