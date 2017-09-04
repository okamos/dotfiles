#!/bin/bash
run_go() {
  if has "go"; then
    echo "Install go packages..."

    go get github.com/motemen/gore
    go get github.com/nsf/gocode
    go get github.com/k0kubun/pp
    go get github.com/golang/lint/golint
    go get github.com/Masterminds/glide
    go get golang.org/x/tools/cmd/...
    go get github.com/golang/dep/...
    ge get github.com/motemen/ghq

    if [[ $OSTYPE =~ "linux" ]]; then
      cd $HOME/dev/src/github.com/peco/peco
      go build cmd/peco/peco.go
      mv peco $HOME/dev/bin/
      cd ${DOT_DIRECTORY}
    fi

    echo "$(tput setaf 2)Install go packages complete. ✔︎$(tput sgr0)"
  fi
}
