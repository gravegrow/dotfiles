set -l FZF_ICONS --prompt '" "' --pointer '" "' --scrollbar '┃'
set -l FZF_BORDERS --border none --preview-window sharp --margin 1
set -l FZF_HEIGHT --height '~99% '--min-height 15
set -l FZF_LAYOUT --reverse --cycle --info=inline-right
set -l FZF_COLORS --color 'gutter:"#181616",pointer:2,scrollbar:4,hl+:1,hl:1,info:3' \
    --color 'fg+:white,bg+:#1F1F22,border:gray' \
    --color 'preview-bg:0,preview-border:0'
set -l FZF_BINDS --bind 'tab:down,shift-tab:up,ctrl-y:accept'


set -gx FZF_DEFAULT_OPTS $FZF_ICONS $FZF_BORDERS $FZF_HEIGHT $FZF_LAYOUT $FZF_COLORS $FZF_BINDS

set -U FZF_COMPLETE 2
set -U FZF_COMPLETE_OPTS --tiebreak=begin --select-1 --info=inline-right --margin=0,1,0,1
