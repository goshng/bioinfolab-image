
# 인자 없는 cd 는 실습 작업 폴더로 이동한다
cd() {
    if [ $# -eq 0 ]; then
        builtin cd "${MYHOME:-$HOME}"
    else
        builtin cd "$@"
    fi
}