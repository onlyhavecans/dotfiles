## Mo Git Mo Problems
alias git hub
alias gitclean 'git branch --merged master | grep -v " master" | grep -v "\*" | xargs -n 1 git branch -d'

abbr --add gad git add --all
abbr --add gap git add --patch
abbr --add gca git commit --signoff --amend --date="(date)"
abbr --add gc git commit --signoff --verbose
abbr --add gp git push
abbr --add gpu git pull
abbr --add gst git status
abbr --add gft git fetch --tags
abbr --add gpr "git push; and git pull-request --browse"
abbr --add gbr git browse
