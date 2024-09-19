function __tmux-crafting
    printf "\033]1337;SetUserVar=%s=%s\007" ZEN_MODE ( echo -n on | base64 )
    set -l pid $(xdotool getactivewindow getwindowgeometry --shell | grep -E "WINDOW" | grep -Eo "[0-9]+")
    xdotool windowmove $pid 1460 20
    xdotool windowsize $pid 520 280

    if ! tmux has-session -t=$argv 2>/dev/null
        tmux new-session -ds $argv
        tmux split-window -t $argv -l 50% -hf
        tmux select-pane -t 1
    end

    tmux attach -t $argv
end


function farm
    __tmux-crafting "system-$argv"
end

