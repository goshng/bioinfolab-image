FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

USER root

# 기본 유틸리티. 03~04번 수업에서 쓰는 명령어들을 포함한다.
RUN apt-get update && apt-get install -y --no-install-recommends \
        bzip2 ca-certificates curl less nano tree unzip wget \
    && rm -rf /var/lib/apt/lists/*

# micromamba 설치 (conda보다 훨씬 빠르다)
RUN curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest \
        | tar -xvj -C /usr/local bin/micromamba

ENV MAMBA_ROOT_PREFIX=/opt/conda
ENV PATH=/opt/conda/envs/bio/bin:$PATH

COPY envs/ /tmp/envs/

# 환경 세 개를 만든다. 서로 의존성이 충돌하므로 분리한다.
RUN micromamba create -y -n bio        -f /tmp/envs/bio.yml        \
 && micromamba create -y -n assembly   -f /tmp/envs/assembly.yml   \
 && micromamba create -y -n annotation -f /tmp/envs/annotation.yml \
 && micromamba clean -a -y \
 && rm -rf /tmp/envs

# 학생이 conda activate를 몰라도 되도록 래퍼 스크립트를 만든다.
# 예: 터미널에서 그냥 shovill 이라고 치면 assembly 환경에서 실행된다.
RUN set -eux; \
    for tool in shovill spades.py; do \
        printf '#!/bin/sh\nexec micromamba run -n assembly %s "$@"\n' "$tool" \
            > /usr/local/bin/"$tool"; \
        chmod 755 /usr/local/bin/"$tool"; \
    done; \
    for tool in prokka; do \
        printf '#!/bin/sh\nexec micromamba run -n annotation %s "$@"\n' "$tool" \
            > /usr/local/bin/"$tool"; \
        chmod 755 /usr/local/bin/"$tool"; \
    done

# 새 터미널을 열 때마다 micromamba를 쓸 수 있도록 설정한다.
RUN echo 'eval "$(micromamba shell hook --shell bash)"' >> /etc/bash.bashrc

USER vscode
WORKDIR /workspaces
