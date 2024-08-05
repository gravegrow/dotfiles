function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cY forward-char
        bind -M $mode \cP up-or-search
        bind -M $mode \cN down-or-search
    end
end
