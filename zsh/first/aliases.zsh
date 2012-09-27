#Good for the iTerm
alias cleanup="sudo rm -rfv /private/var/log/asl/*.asl; sudo rm -rfv /Volumes/*/.Trashes;"

#Work Stuff
alias root='TERM=vt220 ssh -Y $1 -l root'
alias aws='ssh -l root -i ~/.ssh/smcloud.pem $1'
alias usbserial='screen /dev/tty.PL2303-00002006 9600 8 1'

#Remote workspace
alias air='ssh air'
alias serv='ssh -R 23456:localhost:22 vpn'
alias killscreen="killall ScreensharingAgent"

# ZSH Aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias reload!='. ~/.zshrc'
