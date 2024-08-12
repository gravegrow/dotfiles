set __set_dims "$HOME/.config/scripts/crafting-term"

function __wow-crafting
    set -l path /media/games/tools/custom/
    $__set_dims

    if ! tmux has-session -t=$argv 2>/dev/null
        tmux new-session -ds $argv -c $path
    end

    tmux kill-pane -a -t 1
    tmux split-window -t $argv -l 66% -c $path
    tmux split-window -t $argv -l 50% -c $path
    tmux select-pane -t 1

    tmux a -t $argv
end

alias crafting='__wow-crafting aliance'
alias horde-crafting='__wow-crafting horde'

