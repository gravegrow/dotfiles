set -l FZF_ICONS --prompt '"  "' --pointer '" "' --scrollbar '┃'
set -l FZF_BORDERS --border none --preview-window sharp --margin 0,0,0,0
set -l FZF_HEIGHT --height '~99% '
set -l FZF_LAYOUT --reverse --cycle --info=inline-right
set -l FZF_BINDS --bind 'ctrl-y:accept,ctrl-u:preview-up,ctrl-d:preview-down'
set -l FZF_COLORS \
    --color 'gutter:#101010,pointer:2,scrollbar:4,hl+:1,hl:1,info:#474747' \
    --color 'fg+:white,bg+:#202020,border:gray' \
    --color 'preview-bg:-1,preview-border:gray'


set -gx FZF_DEFAULT_OPTS $FZF_ICONS $FZF_BORDERS $FZF_HEIGHT $FZF_LAYOUT $FZF_COLORS $FZF_BINDS
 
set -U FZF_COMPLETE 2
set -U FZF_COMPLETE_OPTS --select-1 --height '25%' --info=inline-right --margin 0,0,0,0
