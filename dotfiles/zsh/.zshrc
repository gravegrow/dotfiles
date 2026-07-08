ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

FPATH="$HOME/.docker/completions:$FPATH"

autoload -Uz compinit && compinit
autoload -U select-word-style
select-word-style bash

zinit light "Aloxaf/fzf-tab"
zinit light "zsh-users/zsh-completions"
zinit light "zsh-users/zsh-autosuggestions"
zinit light "zsh-users/zsh-syntax-highlighting"
zinit snippet OMZP::pyenv
zinit snippet OMZP::zoxide

HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTFILE=$HOME/.cache/zsh_history
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

bindkey -v
bindkey -M viins '^W' backward-kill-word
bindkey -M vicmd '^W' backward-kill-word
bindkey -M visual '^W' backward-kill-word
bindkey -M viins "^[[H" beginning-of-line
bindkey -M viins "^[[F" end-of-line
bindkey -M vicmd "^[[H" beginning-of-line
bindkey -M vicmd "^[[F" end-of-line

bindkey '^W' backward-kill-word
bindkey '^?' backward-delete-char
bindkey '^y' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

[[ -z $LS_COLORS ]] && eval "$(dircolors -b)"

alias ls="eza --color=always"

ZSH_AUTOSUGGEST_HISTORY_IGNORE="(nvim *|./*)"
# ZSH_AUTOSUGGEST_COMPLETION_IGNORE="z *"

ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd)
# ZSH_HIGHLIGHT_STYLES[path]='fg=blue'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=15'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=cyan,bold'

export GOPATH=$HOME/.config/go
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export MANPAGER="$EDITOR +Man!"
export FZF_DEFAULT_OPTS="\
  --prompt '  ' --pointer ' ' --scrollbar '┃' --gutter ' '\
  --border none --preview-window  --reverse --cycle --info inline-right \
  --color pointer:4,scrollbar:4,info:8 \
  --color fg:7,fg+:15,bg+:-1,border:gray \
  --color preview-bg:-1,preview-border:gray \
  --color hl:#D27E99,hl+:#D27E99 \
  --bind ctrl-y:accept,ctrl-u:preview-up,ctrl-d:preview-down"

zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons=always $realpath '
zstyle ':fzf-tab:complete:nvim:*' fzf-preview \
    '[[ -d $realpath ]] && eza -1 --color=always --icons=always $realpath \
    || bat --color=always --style=plain --theme=base16 $realpath'
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-flags --color bg+:#18191A


PROMPT_NEEDS_NEWLINE=false
function precmd() {
  [[ "$PROMPT_NEEDS_NEWLINE" == true ]] && echo ""
  PROMPT_NEEDS_NEWLINE=true
}

function clear() {
  PROMPT_NEEDS_NEWLINE=false
  command clear
}

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q' # Block cursor
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} == "" ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q' # Beam cursor
  fi
}

zle -N zle-keymap-select

_fix_cursor() {
   echo -ne '\e[5 q'
}

precmd_functions+=(_fix_cursor)

function yazi() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

eval "$(fzf --zsh)"
eval "$(starship init zsh)" && clear
