# ------------------------------
# General Settings
# ------------------------------
export EDITOR=vim
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export KCODE=u
export AUTOFEATURE=true

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
autoload -U compinit; compinit
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
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history
setopt hist_ignore_dups
setopt share_history
setopt hist_reduce_blanks
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
### path ###
has() {
  type "$1" > /dev/null 2>&1
}

case "${OSTYPE}" in
  darwin*)
    export PATH=./vendor/bin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:$PATH
    export MANPATH=/opt/local/share/man:/opt/local/man:$MANPATH
  ;;
esac

if type rbenv > /dev/null 2>&1; then
  export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init - --no-rehash)"
fi
if type pyenv > /dev/null 2>&1; then
  export PATH=$HOME/.pyenv/bin:$PATH
  eval "$(pyenv init -)"
fi
if type nodebrew > /dev/null 2>&1; then
  export PATH=$HOME/.nodebrew/current/bin:$PATH
fi
if type go > /dev/null 2>&1; then
  export GOROOT=`go env GOROOT`;
  export GOPATH=$HOME/go;
  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi
if type nvim > /dev/null 2>&1; then
  export XDG_CONFIG_HOME=$HOME/.config
fi
[ -f ~/.zplug/zplug ] && source ~/.zshrc.zplug


autoload -Uz add-zsh-hock
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
autoload -Uz zmv
