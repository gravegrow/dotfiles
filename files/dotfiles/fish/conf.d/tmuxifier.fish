function __tmux-crafting
    printf "\033]1337;SetUserVar=%s=%s\007" ZEN_MODE ( echo -n on | base64 )
    set -l pid $(xdotool getactivewindow getwindowgeometry --shell | grep -E "WINDOW" | grep -Eo "[0-9]+")
    xdotool windowmove $pid 1460 20
    xdotool windowsize $pid 520 280

    set -l SESH "system-$argv"

    if ! tmux has-session -t=$SESH 2>/dev/null
        set -l cmd "alias crafting-actions='crafting-actions $argv'"
        tmux new-session -ds $SESH
        tmux send-keys -t $SESH $cmd C-m
        tmux send-keys -t $SESH C-l

        tmux split-window -t $SESH -l 50% -hf
        tmux send-keys -t $SESH $cmd C-m
        tmux send-keys -t $SESH C-l

        tmux select-pane -t 1
    end

    tmux attach -t "system-$argv"
end


function farm
    __tmux-crafting "$argv"
end
