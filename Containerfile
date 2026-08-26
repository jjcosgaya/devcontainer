# syntax=docker/dockerfile:1
FROM fedora:44

# Tool PATHs declared up front so they work in non-interactive shells too
# (e.g. `podman exec mycontainer cargo build`), not just login shells.
ENV PATH="/root/.local/bin:/root/.cargo/bin:${PATH}"
ENV SHELL=/bin/bash
ENV LANG=en_US.UTF-8

# --- Base packages (rarely changes) ---
# Keep Fedora's recommended dependencies: this is a devbox, so compatibility
# and a complete toolchain matter more than minimizing the image.
RUN dnf install -y \
        bash-completion ca-certificates curl git gh gcc glibc-langpack-en make unzip tar gzip \
        fd-find fzf jq ripgrep gnupg2 "dnf-command(copr)" \
        lsd ncurses-term neovim nodejs24 nodejs24-npm pnpm \
        python3 uv zoxide \
    && dnf copr enable -y lihaohong/yazi \
    && dnf install -y yazi \
    && ln -s "$(command -v python3)" /usr/local/bin/python \
    && dnf clean all \
    && rm -rf /var/cache/dnf

# --- Rust (likewise no profile edits; no redundant `rustup update`) ---
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
        | sh -s -- -y --no-modify-path --default-toolchain stable

# --- Pi coding agent (official installer) ---
RUN curl -fsSL https://pi.dev/install.sh | sh

# --- Personal config LAST: editing these only rebuilds the layers below ---
COPY bashrc /root/.bashrc
RUN touch /root/.bash_history

COPY pi/skills /root/.pi/agent/skills
COPY nvim /root/.config/nvim
# Pre-install nvim plugins at build time so first launch is instant.
# Uncomment the line matching your plugin manager:
RUN nvim --headless "+Lazy! sync" +qa
# RUN nvim --headless +PackerSync +qa

WORKDIR /workspace
CMD ["bash"]
