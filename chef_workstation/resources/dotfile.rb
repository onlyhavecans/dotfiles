property :destination, String, name_property: true, required: true
property :source, String, required: true
property :my_user, String, required: true

action :create do
  # Chef can't overwrite folders with symlinks so destroy it if we find one.
  directory destination do
    recursive true
    action    :delete
    only_if { !::File.symlink?(destination) && ::File.directory?(destination) }
  end

  link destination do
    to   source
    user my_user
  end
end

action :delete do
  link destination do
    action :delete
  end
end
