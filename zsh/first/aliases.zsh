alias reload!='. ~/.zshrc'
alias killscreen="killall ScreensharingAgent"

#Good for the iTerm
alias cleanup="sudo rm -rfv /private/var/log/asl/*.asl; sudo rm -rfv /Volumes/*/.Trashes;"

#Work Stuff
alias root='TERM=vt220 ssh -Y $1 -l root'
alias aws='ssh -l root -i ~/.ssh/smcloud.pem $1'
alias usbserial='screen /dev/tty.PL2303-00002006 9600 8 1'
alias air='ssh air'

# ZSH Aliases
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
