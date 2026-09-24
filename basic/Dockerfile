# 1단계: 가장 단순한 환경
# 02~07주차 (Codespaces 적응, bash, 파이썬 기초)에 사용한다.
# 생물정보학 도구는 하나도 들어 있지 않다. 그래서 빠르다.

FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04
USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
        bzip2 ca-certificates curl less nano tree unzip wget \
        python3 python3-pip \
    && rm -rf /var/lib/apt/lists/*

# 인자 없는 cd 를 작업 폴더로 보내는 함수. 위 단계 이미지가 모두 물려받는다.
COPY common/cdhome.sh /tmp/cdhome.sh
RUN cat /tmp/cdhome.sh >> /etc/bash.bashrc && rm /tmp/cdhome.sh

USER vscode
WORKDIR /workspaces
