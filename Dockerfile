FROM ubuntu:24.04

COPY bashrc /root/.bashrc
COPY nvim /root/.config/nvim
RUN touch /root/.bash_history

WORKDIR /workspace

RUN apt update && apt install curl git gh gcc make fd-find fzf jq gnupg lsb-release -y

RUN curl -sS https://debian.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc \
    | gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/debian.griffo.io.gpg \
    && echo "deb https://debian.griffo.io/apt $(lsb_release -sc) main" \
       > /etc/apt/sources.list.d/debian.griffo.io.list \
    && apt update \
    && apt install -y yazi \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    ARCH="$(uname -m)"; \
    case "$ARCH" in \
        x86_64)  NVIM_ARCH="x86_64" ;; \
        aarch64) NVIM_ARCH="arm64" ;; \
        *)       echo "Unsupported architecture: $ARCH"; exit 1 ;; \
    esac; \
    curl -LO "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${NVIM_ARCH}.tar.gz"; \
    tar xzf "nvim-linux-${NVIM_ARCH}.tar.gz"; \
    mv "nvim-linux-${NVIM_ARCH}" /usr/local/nvim; \
    ln -s /usr/local/nvim/bin/nvim /usr/local/bin/nvim; \
    rm "nvim-linux-${NVIM_ARCH}.tar.gz"

RUN curl -LsSf https://astral.sh/uv/install.sh | sh

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | PROFILE="${BASH_ENV}" bash
RUN bash -c "source /root/.nvm/nvm.sh && nvm install --lts && npm install -g pnpm"

ENV PATH="/root/.cargo/bin:${PATH}"
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && rustup update

RUN ln -s /usr/bin/python3 /usr/bin/python

CMD ["bash"]
