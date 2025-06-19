FROM mcr.microsoft.com/devcontainers/rust:1-bookworm

ARG NODE_VERSION="20"
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
    && apt-get update \
    && apt-get install -y nodejs \
    && npm install -g @vue/cli \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

CMD [ "/bin/bash" ]