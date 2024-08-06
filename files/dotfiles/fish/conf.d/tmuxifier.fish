set __set_dims "$HOME/.config/scripts/crafting-term"

function __wow-crafting
    $__set_dims
    set path /media/games/tools/custom/
    tmux new-session -ds $argv -c $path
    tmux split-window -t $argv -l 66% -c $path
    tmux split-window -t $argv -l 50% -c $path
    tmux select-pane -t 1
    sleep 0.2
    tmux a -t $argv
end

alias crafting='__wow-crafting aliance'
alias horde-crafting='__wow-crafting horde'

