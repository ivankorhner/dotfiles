# git
alias g='git'

# status
alias gs='git status -sb'

# add
alias ga='git add'
alias gaa='git add -A'
alias gap='git add -p'

# commit
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'

# branch
alias gb='git branch'
alias gbd='git branch -d'
alias gbD='git branch -D'

# checkout / switch
alias gco='git checkout'
alias gcb='git checkout -b'

# log
alias gl='git log --oneline --graph --decorate --all'
alias gll='git log --stat'
alias glp='git log -p'
alias gln='git log --name-only'

# diff
alias gd='git diff'
alias gdc='git diff --cached'
alias gds='git diff --stat'

# push / pull
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpl='git pull --rebase --autostash'

# fetch
alias gf='git fetch'
alias gfa='git fetch --all --prune'

# stash
alias gst='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gsta='git stash apply'

# restore / reset
alias grs='git restore'
alias grss='git restore --staged'
alias grh='git reset HEAD'

# show
alias gsh='git show'

# tags
alias gt='git tag'
alias gta='git tag -a'

# remote
alias gr='git remote -v'

# cleanup merged branches
alias gbc='git branch --merged | grep -v "\*" | grep -v main | xargs -n 1 git branch -d'
