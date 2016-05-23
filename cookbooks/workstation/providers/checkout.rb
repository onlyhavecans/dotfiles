def whyrun_supported?
  true
end

use_inline_resources

action :clone do
  if @current_resource.exists
    Chef::Log.info "#{ @new_resource } already exists - nothing to do."
  else

    Chef::Resource.send(:include, Workstation::Mixin)
    Chef::Recipe.send(:include, Workstation::Mixin)

    directory @new_resource.directory do
      owner     workstation_user
      recursive true
      action    :create
    end

    bash "clone_#{@new_resource.name}" do
      code "git clone #{@new_resource.repo_url} ."
      cwd  @new_resource.directory
      user workstation_user
    end

  end
end

action :remove do
  if not @current_resource.exists
    Chef::Log.info "#{ @new_resource } already does not exist - nothing to do."
  else
    directory @new_resource.directory do
      recursive true
      action    :delete
    end
  end
end

def load_current_resource
  if ::File.exist?(@new_resource.directory)
    @current_resource.exists = true
  end
end
