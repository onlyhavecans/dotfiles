actions :clone, :remove
default_action :install

attribute :directory, :kind_of => String, :name_attribute => true
attribute :repo_url,  :kind_of => String, :required => true

attr_accessor :exists

