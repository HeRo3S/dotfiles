#!/usr/bin/env bash

selected_branch=$(git branch | fzf | tr -d " *")
if [[ -z "$selected_branch" ]]; then
    return 0
fi
echo "$selected_branch"
selected_commits=$(git log --oneline "$selected_branch" | \
    fzf -m --ansi \
    --preview 'git show --color=always {1}' \
    --preview-window right:0%:wrap \
)
if [[ -z "$selected_commits" ]]; then
    return 0
fi

mapfile -t selected_hashes < <(echo "$selected_commits" | sed 's/ .*$//' | grep -v '^$')

if [ ${#selected_hashes[@]} -eq 0 ]; then
    return 0
fi

echo "${selected_hashes[@]}"
git cherry-pick -m 1 "${selected_hashes[@]}"
