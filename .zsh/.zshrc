# ------------------------------
# General Settings
# ------------------------------
export EDITOR=nvim
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export KCODE=u
export AUTOFEATURE=true
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export TERM=screen-256color

bindkey -e

setopt no_beep
setopt auto_cd
setopt auto_pushd
setopt correct
setopt magic_equal_subst
setopt prompt_subst
setopt notify
setopt equals

### Complement ###
setopt auto_list                     # 補完候補を一覧で表示する(d)
setopt auto_menu                     # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed
setopt list_types
bindkey "^[[Z" reverse-menu-complete # Shift-Tabで補完候補を逆順する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

### Glob ###
setopt extended_glob
unsetopt caseglob

### History ###
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history
setopt hist_ignore_dups
setopt share_history
setopt hist_reduce_blanks
setopt hist_ignore_space
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
function history-all { history -E 1 }

# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
autoload -Uz colors; colors
tmp_prompt="%{${fg[cyan]}%}%n[%c] %{${reset_color}%}"
# if root user
[ ${UID} -eq 0 ] && tmp_prompt="%B%U${tmp_prompt}%u%b"
PROMPT=$tmp_prompt
# if ssh
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"

# ------------------------------
# Other Settings
# ------------------------------
has() {
  type "$1" > /dev/null 2>&1
}

case "${OSTYPE}" in
  darwin*|linux-gnu)
    export PATH=./vendor/bin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:$PATH
    export MANPATH=/opt/local/share/man:/opt/local/man:$MANPATH
  ;;
esac

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH=$HOME/dev/github.com/flutter/flutter/bin:$PATH
export PATH="$HOME/dev/bin:$PATH"
export PATH=$PATH:$XDG_CONFIG_HOME/composer/vendor/bin

fpath=(/usr/local/share/zsh/site-functions $fpath)
autoload -Uz add-zsh-hock
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
autoload -Uz zmv

# extra function
function google() {
    local str opt
    if [ $# != 0 ]; then
        for i in $*; do
            str="$str+$i"
        done
        str=`echo $str | sed 's/^\+//'`
        opt='search?num=50&hl=ja&lr=lang_ja'
        opt="${opt}&q=${str}"
    fi
    w3m http://www.google.co.jp/$opt
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(/opt/homebrew/bin/brew shellenv)"
. $(brew --prefix asdf)/libexec/asdf.sh

# Created by `pipx` on 2022-03-30 08:38:37
export PATH="$PATH:/Users/okamoto_shinichi/.local/bin"
source ${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light greymd/tmux-xpanes
zinit light paulirish/git-open
autoload bashcompinit && bashcompinit
