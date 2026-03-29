function fish_user_key_bindings
    set -l sessionizer "$HOME/.config/scripts/tmux-sessionizer-new"
    set -l project_root "/media/storage/development"

    for mode in insert default visual
        bind -M $mode \cY forward-char
        bind -M $mode \cP up-or-search
        bind -M $mode \cN down-or-search

        bind -M $mode alt-i "$sessionizer Dotfiles $HOME/.config/dotfiles/files/dotfiles/"
        bind -M $mode alt-n "$sessionizer Notes    $project_root/notes"
        bind -M $mode alt-m "$sessionizer Maya     $project_root/maya/"
        bind -M $mode alt-u "$sessionizer Unity    $project_root/unity/ $project_root/unity/projects"
        bind -M $mode alt-p "$sessionizer Devel    $project_root/cpp \
                                                   $project_root/godot \
                                                   $project_root/projects \
                                                   $project_root/warcraft"

    end
end
