# Change window name to the current git dir
change_tmux_window_name() {
  ! [[ -n $TMUX ]] && return;

  if git rev-parse 2> /dev/null; then
    tmux rename-window "$(basename `git rev-parse --show-toplevel`)"
  else
    tmux setw automatic-rename
  fi
}
add-zsh-hook chpwd change_tmux_window_name
change_tmux_window_name
