require 'chefspec'
require 'chefspec/berkshelf'

at_exit { ChefSpec::Coverage.report! }

RSpec.configure do |config|
  config.log_level = :fatal

  # Guard against people using deprecated RSpec syntax
  config.raise_errors_for_deprecations!

  # Why aren't these the defaults?
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  # Be random!
  config.order = 'random'
end
