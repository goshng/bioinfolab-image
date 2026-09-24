# 3단계: 서열 분석용
# 08~09, 12~14주차에 사용한다.

FROM ghcr.io/goshng/bioinfolab:conda
USER vscode

COPY --chown=vscode:vscode envs/seq.yml /tmp/seq.yml
RUN micromamba create -y -n bio -f /tmp/seq.yml \
    && micromamba clean -a -y \
    && rm /tmp/seq.yml

# bio 환경의 도구를 활성화 없이 바로 쓸 수 있게 한다.
ENV PATH=/opt/conda/envs/bio/bin:$PATH
WORKDIR /workspaces
