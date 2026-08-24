# devcontainer

Personal terminal development environment with shared Bash, Neovim, and Pi configuration.

## Images

Fedora 44 is the default image and provides recent, stable packages:

```sh
podman build -t devbox -f Containerfile .
```

Ubuntu 24.04 remains available as an alternative:

```sh
podman build -t devbox:ubuntu -f Containerfile.ubuntu .
```

The Fedora image uses DNF packages for Neovim, Node.js, pnpm, uv, and the other packaged tools; Yazi comes from its recommended COPR repository. Rust and Pi use their official installers. The repository's `pi/skills` directory is copied to `~/.pi/agent/skills` in both images.

Run either image with the current directory mounted as the workspace:

```sh
podman run --rm -it -v "$PWD:/workspace" devbox
```
