# Dockerfile do ambiente de desenvolvimento das Funções ZZ.
# Feito para ser usado no VS Code ou via web com o GitHub Codespaces.

# A imagem base é um Ubuntu 22.04 com git e ferramentas de
# desenvolvimento para shell e Python. Veja detalhes em
# https://github.com/aureliojargas/devcontainer
FROM ghcr.io/aureliojargas/devcontainer

# Instala softwares adicionais que são requisitos para algumas funções
RUN apt update && export DEBIAN_FRONTEND=noninteractive \
    && apt --yes install --no-install-recommends \
    bc \
    file \
    gawk \
    links \
    && rm -rf /var/lib/apt/lists/*

# O 'mawk' é removido para que o 'gawk' tenha precedência quando chamar
# o comando 'awk'. https://github.com/funcoeszz/funcoeszz/issues/753
RUN apt --yes remove mawk

# Configura as Funções ZZ
# O repositório das ZZ será colocado em /workspaces/funcoeszz/
ENV PATH=/workspaces/funcoeszz:$PATH \
    ZZPATH=/workspaces/funcoeszz/funcoeszz \
    ZZDIR=/workspaces/funcoeszz/zz \
    ZZTMPDIR=/tmp \
    LC_ALL=C.UTF-8
