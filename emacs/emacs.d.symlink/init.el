; Kill these unnecessary modes.
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
;(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
;(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

; I need themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/solarized")
(load-theme 'solarized-dark t)
(set-face-attribute 'default nil :font "PragmataPro-16")

;I use a lot of markdown
(add-to-list 'load-path "~/.emacs.d/markdown-mode")
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.txt\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

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
