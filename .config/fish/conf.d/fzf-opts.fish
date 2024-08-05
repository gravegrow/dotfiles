set -gx FZF_DEFAULT_OPTS "\
--prompt ' ' --pointer ➤ \
--border sharp --preview-window sharp \
--height=~100% --min-height=15 --reverse --cycle --info=right \
--color=gutter:-1,pointer:1,hl+:1,hl:1,info:3,\
fg+:#b6b2af,bg+:#25211E,border:#544C45,\
preview-bg:0,preview-border:0 \
--bind tab:down,shift-tab:up \
"
