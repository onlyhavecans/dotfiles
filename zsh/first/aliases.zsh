#Good for the iTerm
alias cleanup="/usr/bin/sqlite3 ~/Library/Mail/V2/MailData/Envelope\ Index vacuum; sudo rm -rfv /private/var/log/asl/*.asl; sudo rm -rfv /Volumes/*/.Trashes;"

#Work Stuff
alias root='TERM=vt220 ssh -Y $1 -l root -i /Volumes/iamaKey/ssh/DHA-SM_rsa'
alias aws='TERM=xterm-256color ssh -l root -i /Volumes/iamaKey/ssh/smcloud.pem $1'
alias usbserial='screen /dev/tty.PL2303-00002006 9600 8 1'

#Remote workspace
alias key="ssh -F /Volumes/iamaKey/ssh/ssh_config"
alias mish="mosh --ssh='ssh -F /Volumes/iamaKey/ssh/ssh_config'"
alias killscreen="killall ScreensharingAgent"

# ZSH Aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias reload!='. ~/.zshrc'
