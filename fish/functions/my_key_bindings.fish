function my_key_bindings --description 'My custom keybinds with jk'
	fish_hybrid_key_bindings
  fzf_key_bindings

  bind -M insert -m default jk backward-char force-repaint
  bind -M insert -m default kj backward-char force-repaint
end
