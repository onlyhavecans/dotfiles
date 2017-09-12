function fish_greeting
  if test -x "/usr/local/bin/ponysay"
    /usr/local/bin/ponysay --restrict NAME=Rarity --ponyonly
  else if test -x "/usr/local/bin/archey"
    /usr/local/bin/archey --color --offline --packager
  else if test -x "/usr/local/bin/bsdinfo"
    /usr/local/bin/bsdinfo
  end
end
