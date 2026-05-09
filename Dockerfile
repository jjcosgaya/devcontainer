FROM ubuntu:24.04

COPY bashrc /root/.bashrc
COPY nvim /root/.config/nvim
RUN touch /root/.bash_history

WORKDIR /workspace

RUN apt update && apt install curl git gh gcc make fd-find fzf jq -y

ENV PATH="/root/.cargo/bin:${PATH}"
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && rustup update
RUN cargo install --force yazi-build

RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz \
    && tar xzf nvim-linux-x86_64.tar.gz \
    && mv nvim-linux-x86_64 /usr/local/nvim \
    && ln -s /usr/local/nvim/bin/nvim /usr/local/bin/nvim \
    && rm nvim-linux-x86_64.tar.gz

RUN curl -LsSf https://astral.sh/uv/install.sh | sh
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | PROFILE="${BASH_ENV}" bash
RUN ln -s /usr/bin/python3 /usr/bin/python

RUN bash -c "source /root/.nvm/nvm.sh && nvm install --lts && npm install -g pnpm"

CMD ["bash"]
