function __tmux_file_runner --on-variable PWD --description 'Run .tmux.session'
  status --is-command-substitution; and return

  # if test -f ".tmux.session";
  #   tmux new-session -A -s $PWD
  #   /bin/bash ".tmux.session"
  # end

end
