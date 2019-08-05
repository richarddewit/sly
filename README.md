# Sly
A CLI tool utilizing plain Bash functions.

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

```bash
ping_home() {
  ping -c ${1-5} 127.0.0.1
  screenfetch
}
```

Then run it with `sly ping_home 10` to do 10 pings to localhost and run `screenfetch` afterwards. Or run without arguments (`sly ping_home`) to do the default 5 pings instead of 10.
