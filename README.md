# vim-built-with-docker


An experiment in building Vim inside a Ubuntu 18.04 Docker container.


## Motivation
Building vim requires pulling in a number of dependencies, most of which
consist of development headers that are ultimately unneeded after building it.
This represents a clean way to do so.

It is important to note that the resulting vim binary will only work if the
necessary libraries are installed.


## Building

A shim [`Makefile`](Makefile) can be used to build both the image and vim, and
install the latter:

```bash
$ make
$ make install
```

## Installing

By default, the prefix to which vim is installed is `/usr/local`. This can be
changed by setting `PREFIX`:

```bash
$ make install PREFIX=~/.local
```

However, elevated permissions may be needed if installing to a write-protected
location.

## Upgrading

Should it be necessary to upgrade to a newer version of vim, we can uninstall
and then explicitly install a different version by overriding the `VERSION`
variable:

```bash
$ make uninstall
$ make install VERSION=8.0.1202
```
