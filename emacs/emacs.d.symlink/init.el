(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

; Pi's Demands
(defun two-pi-r-bind-keys-in-map (mode-map keys-alist)
  "Given a mode's map and a list of (key . func) pairs, define said key in that map."
  (mapc
   #'(lambda (_)
       (let ((key (car _))
             (func (cdr _)))
         (define-key mode-map key func)))
     keys-alist))

(two-pi-r-bind-keys-in-map
  (current-global-map)
     ; enter properly indents, like :set si in vi
   '(("\C-m"     . newline-and-indent)
     ; Make this a little more shellish.
     ("\C-w"     . backward-kill-word)
     ("\C-x\C-k" . kill-region)
     ("\C-c\C-k" . kill-region)
     ; Make these a little more SANE.
     ("\C-x+"    . enlarge-window)
     ("\C-x-"    . shrink-window)
     ("\C-x^"    . what-cursor-position)
     ("\C-x="    . balance-windows)
     ("\C-cs"    . ispell-word)
     ("\C-ca"    . org-agenda)
     ("\C-cl"    . org-store-link)
     ("\C-x\C-z" . repeat)
     ("\C-z"     . repeat)
     ("\C-x\C-b" . ido-switch-buffer)
     ))

