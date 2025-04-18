#!/usr/bin/env bash

cwd="$(pwd)"
find . -print0 -type d | while IFS= read -r -d '' file; do
    if [ ! -d "${file}/.git" ]; then
      continue
    fi

    cd "${file}"
    if [[ -n $(git status -s) ]]; then
      echo "Repo ${file} has modified/untracked changes"
    fi
    cd "${cwd}"
done
