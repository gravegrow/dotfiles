set -gx PATH $PATH "/media/storage/software/tmuxifier/bin" 

alias tml="tmuxifier load-session"
alias tme="tmuxifier edit-session"
alias tmn="tmuxifier new-session"

set set_dims "$HOME/.config/scripts/crafting-term"

alias crafting='$set_dims && tmuxifier load-session wow-crafting'
alias horde-crafting='$set_dims && tmuxifier load-session horde-crafting'

