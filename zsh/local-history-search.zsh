#Since I'm a touch typist, I almost alway use Ctrl-P and Ctrl-N to browse the
#history list, so I have them set to only visit local history.  I then leave
#up-arrow and down-arrow set to browse the whole list (as does searching).
# Here's how I do it:

bindkey '^p' up-line-or-local-history
bindkey '^n' down-line-or-local-history

up-line-or-local-history() {
    zle set-local-history 1
    zle up-line-or-history
    zle set-local-history 0
}
zle -N up-line-or-local-history
down-line-or-local-history() {
    zle set-local-history 1
    zle down-line-or-history
    zle set-local-history 0
}
zle -N down-line-or-local-history
