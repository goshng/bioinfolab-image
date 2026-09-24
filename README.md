# bioinfolab-image

생물정보학실험 수업용 Codespaces 이미지를 만드는 저장소이다.
학생은 이 저장소를 볼 일이 없다. 결과물인 이미지만 ghcr.io 를 통해 사용한다.

## 네 단계 이미지

아래 단계는 서로 위에 쌓인다. `conda` 는 `basic` 을, `seq` 는 `conda` 를,
`genome` 은 `seq` 를 `FROM` 으로 가져다 쓴다.

| 태그 | 내용 | 쓰는 주차 |
|------|------|-----------|
| `basic` | 우분투 + 기본 명령어 + python3 | 02~07 |
| `conda` | basic + micromamba (패키지 없음) | conda 실습 |
| `seq` | conda + seqkit, blast, mafft, iqtree, fastqc, fastp | 08~09, 12~14 |
| `genome` | seq + shovill, spades, prokka | 10~11 |

`conda` 에 패키지를 넣지 않은 것은 의도한 것이다. 학생이 직접
`micromamba create` 와 `micromamba install` 을 해 보는 실습에 쓴다.

## 폴더 구조

```
common/cdhome.sh      모든 이미지가 물려받는 터미널 설정
basic/Dockerfile      1단계
conda/Dockerfile      2단계
seq/Dockerfile        3단계
genome/Dockerfile     4단계
envs/*.yml            conda 환경 정의
```

## 고치는 방법

도구를 추가하려면 해당 `envs/*.yml` 에 한 줄 넣고 push 한다.
터미널 동작을 바꾸려면 `common/cdhome.sh` 를 고친다. 네 이미지에 모두 반영된다.

push 하면 Actions 가 순서대로 다시 빌드한다. 아래 단계를 고치면 그 위 단계도
함께 다시 빌드되므로 시간이 걸린다.

## 처음 설정할 때

1. 이 파일들을 저장소에 올린다.
2. Actions 탭에서 빌드가 끝날 때까지 기다린다. 첫 빌드는 한 시간 가까이 걸릴 수 있다.
3. **계정 화면 → Packages → bioinfolab → Package settings → Change visibility → Public**
   이 단계를 빠뜨리면 학생 Codespace 가 이미지를 내려받지 못한다.

## 주의

- Dockerfile 안의 `FROM ghcr.io/goshng/...` 에서 `goshng` 부분을 본인 계정으로 바꾼다.
- 학기 중에 이미지를 고치면, 이미 만들어진 Codespace 는 옛 이미지를 계속 쓴다.
  Codespace 를 새로 만들거나 Rebuild Container 를 해야 반영된다.
