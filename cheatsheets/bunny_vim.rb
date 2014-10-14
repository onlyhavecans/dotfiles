cheatsheet do
  title 'Bunny Vim'
  docset_file_name 'bunny_vim'
  keyword 'bvim'

  introduction 'All my Custom and forgettable vim'

  ## Reminders
  # You can have multiple commands
  # notes are also a good section

  category do
    id 'F Keys'
    entry do
      command '<F1>'
      name 'Disabled'
    end
    entry do
      command '<F2>'
      name 'Line number Toggle'
    end
    entry do
      command '<F3>'
      name 'NERDTree Toggle'
    end
    entry do
      command '<F4>'
      name '81st Column color toggle'
    end
    entry do
      command '<F5>'
      name 'Dropzone'
    end
    entry do
      command '<F6>'
      name 'CD to current file'
    end
    entry do
      command '<F7>'
      name 'Toggle Pase Mode'
    end
  end

  category do
    id 'Normal Mode Shortcut'
    entry do
      command '//'
      name 'Clear search highlight'
    end
    entry do
      command 'Q'
      name 'Rewap text'
    end
    entry do
      command 'Y'
      name 'copy from current char to end of line'
    end
  end

  category do
    id 'Leader codes'
    entry do
      command '<L>a='
      name 'Tabularize at ='
    end
    entry do
      command '<L>a:'
      name 'Tabularize at :'
    end
    entry do
      command '<L>a.'
      name 'Tabularize at .'
    end
    entry do
      command '<L>c'
      name 'TComment block'
    end
    entry do
      command '<L>d'
      name 'delete without adding to yank stack (use with all forms of d)'
    end
    entry do
      command '<L>D'
      name 'Dash search current word'
    end
    entry do
      command '<L>f'
      name 'Kill all folding'
    end
    entry do
      command '<L>h'
      name 'highlight changed lines with GitGutter'
    end
    entry do
      command '<L>n'
      name 'NERDTree Toggle'
    end
    entry do
      command '<L>o'
      name 'Start Obsessing'
    end
    entry do
      command '<L>r'
      name 'Reload vim config'
    end
    entry do
      command '<L>s'
      name 'sort lines under crusor'
    end
    entry do
      command '<L>w'
      name 'Strip all trailing whitespace'
    end
    entry do
      command '<L>z'
      name 'Pop open new tab /w copy of buffer (zoom)'
    end

  end

  category do
    id 'UltiSnips'
    entry do
      command ':UltiSnipsEdit'
      name 'Make more snips'
    end
    entry do
      command 'entry\t'
      name 'cheatset entry'
    end
  end

  category do
    id 'All mode shortcuts'
    entry do
      command 'kj'
      name 'esc shortcut'
    end
    entry do
      command '^s'
      name 'save'
    end
  end

  category do
    id 'vimdiff'
    entry do
      command 'dp'
      name '(p)ush change over to other file. merge'
    end
  end
end
