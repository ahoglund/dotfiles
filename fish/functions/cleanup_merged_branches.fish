function cleanup_merged_branches
  set default_branch (git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@') 2>/dev/null
  git branch --merged $default_branch | grep -v $default_branch | xargs -n 1 git branch -d
end
