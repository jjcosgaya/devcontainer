# devcontainer

Personal terminal development environment with shared Bash and Neovim configuration.

## Images

Fedora 44 is the default image and provides recent, stable packages:

```sh
podman build -t devbox -f Containerfile .
```

Ubuntu 24.04 remains available as an alternative:

```sh
podman build -t devbox:ubuntu -f Containerfile.ubuntu .
```

Run either image with the current directory mounted as the workspace:

```sh
podman run --rm -it -v "$PWD:/workspace" devbox
```
