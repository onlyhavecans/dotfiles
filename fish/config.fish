if status --is-interactive
  set PATH /opt/chefdk/bin /opt/chefdk/embedded/bin $HOME/.chefdk/gem/ruby/2.1.0/bin /usr/local/sbin /usr/local/bin $PATH;
  /usr/local/bin/archey --color
end
