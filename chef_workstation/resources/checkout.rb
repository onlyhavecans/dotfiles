property :directory, String, name_property: true
property :repo_url,  String, required: true
property :owner, String, required: true

action :clone do
  directory new_resource.directory do
    owner     new_resource.owner
    recursive true
    action    :create
  end

  bash "clone_#{new_resource.name}" do
    code "git clone #{new_resource.repo_url} ."
    cwd  new_resource.directory
    user new_resource.owner
  end
end

action :remove do
  directory new_resource.directory do
    recursive true
    action    :delete
  end
end
