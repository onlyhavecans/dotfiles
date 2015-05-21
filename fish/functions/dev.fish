function dev --description "Log into dev"
  set -lx TERM xterm
  ssh -A -l davidaronsohn sdhq-dev01.sdhq.local
end
