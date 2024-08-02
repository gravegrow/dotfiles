#!/bin/bash

if command -v tmux &> /dev/null
then
    tmux new-session -As "Session"
    exit 0
fi

$SHELL
