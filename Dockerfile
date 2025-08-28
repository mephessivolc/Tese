FROM ubuntu:latest
# Evita prompts interativos
ENV DEBIAN_FRONTEND=noninteractive

# Instala LaTeX completo + utilitários básicos
RUN apt-get update && apt-get install -y \
    texlive-full \
    latexmk \
    make \
    git \
    bash \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Define diretório de trabalho dentro do container
WORKDIR /workspace

# Inicia no bash por padrão
CMD ["/bin/bash"]
