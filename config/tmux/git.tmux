#!/bin/bash

is_dirty() {
  if [ $(git --no-optional-locks status -s | wc -l) = 0 ]; then
    echo "#[fg=green]⎇ "
  else
    echo "#[fg=yellow]⎇ "
  fi
}

get_status() {
  if [ -d .git ]; then
    status="#[fg=default]$(basename `git --no-optional-locks rev-parse --show-toplevel`)"
    status="$status $(is_dirty) $(git --no-optional-locks rev-parse --abbrev-ref HEAD)"
    echo "  $status"
  else
    status="#[fg=default]$(pwd | sed "s|^$HOME|~|")"
    echo "  $(basename $status)"
  fi
}

cd "$1"
cd $(git --no-optional-locks rev-parse --show-toplevel || echo ".")
get_status
