function tmux-venv
    source .venv/bin/activate.fish
    tmux set-environment VIRTUAL_ENV $VIRTUAL_ENV
end
