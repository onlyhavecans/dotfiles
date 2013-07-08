#Good for the iTerm
alias cleanup="/usr/bin/sqlite3 ~/Library/Mail/V2/MailData/Envelope\ Index vacuum; sudo rm -rfv /private/var/log/asl/*.asl; sudo rm -rfv /Volumes/*/.Trashes;"
#Broken out becasue this is fairly disruptive to the system
alias launchRegister=" /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"

#Work Stuff
alias root='TERM=xterm-256color ssh -Y $1 -l root'
alias aws='TERM=xterm-256color ssh $1 -l ec2-user'
alias usbserial='screen /dev/tty.PL2303-00002006 9600 8 1'

#Brew annoyfix
alias gpg=gpg2

#gitplz
alias gap='git add -p'
alias assume=update-index --assume-unchanged
alias unassume=update-index --no-assume-unchanged
alias assumed="!git ls-files -v | grep ^h | cut -c 3-"

#Remote workspace
alias killscreen="killall ScreensharingAgent"

# ZSH Aliases
alias zshconfig="emacs ~/.zshrc"
alias ohmyzsh="emacs ~/.oh-my-zsh"
alias reload!='. ~/.zshrc'
