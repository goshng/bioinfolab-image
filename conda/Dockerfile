# 2단계: conda 실습용
# micromamba 만 설치되어 있고 패키지는 없다.
# 학생이 직접 환경을 만들고 패키지를 설치해 보는 주차에 사용한다.

FROM ghcr.io/goshng/bioinfolab:basic
USER root

RUN curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest \
        | tar -xvj -C /usr/local bin/micromamba

ENV MAMBA_ROOT_PREFIX=/opt/conda

# 학생이 sudo 없이 환경을 만들 수 있도록 소유권을 넘긴다.
RUN mkdir -p /opt/conda && chown -R vscode:vscode /opt/conda \
    && echo 'eval "$(micromamba shell hook --shell bash)"' >> /etc/bash.bashrc

USER vscode
WORKDIR /workspaces
