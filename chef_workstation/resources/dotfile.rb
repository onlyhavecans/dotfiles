property :destination, String, name_property: true, required: true
property :source, String, required: true
property :my_user, String, required: true

action :create do
  # Chef can't overwrite folders with symlinks so destroy it if we find one.
  directory new_resource.destination do
    recursive true
    action    :delete
    only_if { !::File.symlink?(new_resource.destination) && ::File.directory?(new_resource.destination) }
  end

  link new_resource.destination do
    to   new_resource.source
    user new_resource.my_user
  end
end

action :delete do
  link new_resource.destination do
    action :delete
  end
end
