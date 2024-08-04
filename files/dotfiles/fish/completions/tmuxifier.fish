set -l tmuxifier_commands load-session load-window list list-sessions list-windows new-session new-window edit-session edit-window commands version help 
complete -f -c tmuxifier -n "not __fish_seen_subcommand_from $tmuxifier_commands" -a load-session  --description "Load the specified session layout."
complete -f -c tmuxifier -n "not __fish_seen_subcommand_from $tmuxifier_commands" -a load-window   --description "Load the specified window layout into current session."
complete -f -c tmuxifier -n "not __fish_seen_subcommand_from $tmuxifier_commands" -a list          --description "List all session and window layouts."
complete -f -c tmuxifier -n "not __fish_seen_subcommand_from $tmuxifier_commands" -a list-sessions --description "List session layouts."
complete -f -c tmuxifier -n "not __fish_seen_subcommand_from $tmuxifier_commands" -a list-windows  --description "List window layouts."
complete -f -c tmuxifier -n "not __fish_seen_subcommand_from $tmuxifier_commands" -a new-session   --description "Create new session layout and open it with $EDITOR."
complete -f -c tmuxifier -n "not __fish_seen_subcommand_from $tmuxifier_commands" -a new-window    --description "Create new window layout and open it with $EDITOR."
complete -f -c tmuxifier -n "not __fish_seen_subcommand_from $tmuxifier_commands" -a edit-session  --description "Edit specified session layout with $EDITOR."
complete -f -c tmuxifier -n "not __fish_seen_subcommand_from $tmuxifier_commands" -a edit-window   --description "Edit specified window layout with $EDITOR."
complete -f -c tmuxifier -n "not __fish_seen_subcommand_from $tmuxifier_commands" -a commands      --description "List all tmuxifier commands (including internal)."
complete -f -c tmuxifier -n "not __fish_seen_subcommand_from $tmuxifier_commands" -a version       --description "Print Tmuxifier version."
complete -f -c tmuxifier -n "not __fish_seen_subcommand_from $tmuxifier_commands" -a help          --description "Show this message."

