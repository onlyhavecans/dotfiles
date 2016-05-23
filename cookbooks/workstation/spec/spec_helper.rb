require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  # config.log_level = :warn

  config.platform = 'mac_os_x'

  config.version = '10.11.1'
end

# at_exit { ChefSpec::Coverage.report! }
