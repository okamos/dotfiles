export ZDOTDIR=$HOME/.zsh

# tmux 内で kiro-cli-term の exec による 2 重シェル起動を回避
[[ -n "$TMUX" ]] && export Q_TERM_TMUX=1
