# 4단계: 유전체 조립과 주석용
# 10~11주차에만 사용한다. 용량이 가장 크다.

FROM ghcr.io/goshng/bioinfolab:seq
USER vscode

COPY --chown=vscode:vscode envs/assembly.yml /tmp/assembly.yml
COPY --chown=vscode:vscode envs/annotation.yml /tmp/annotation.yml

RUN micromamba create -y -n assembly   -f /tmp/assembly.yml \
    && micromamba create -y -n annotation -f /tmp/annotation.yml \
    && micromamba clean -a -y \
    && rm /tmp/assembly.yml /tmp/annotation.yml

# 학생이 micromamba activate 를 몰라도 되도록 래퍼를 만든다.
USER root
RUN set -eux; \
    for t in shovill spades.py; do \
        printf '#!/bin/sh\nexec micromamba run -n assembly %s "$@"\n' "$t" \
            > /usr/local/bin/"$t"; \
        chmod 755 /usr/local/bin/"$t"; \
    done; \
    printf '#!/bin/sh\nexec micromamba run -n annotation prokka "$@"\n' \
        > /usr/local/bin/prokka; \
    chmod 755 /usr/local/bin/prokka

USER vscode
WORKDIR /workspaces
