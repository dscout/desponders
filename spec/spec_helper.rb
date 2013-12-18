require 'bundler'
Bundler.setup

require 'active_support'
require 'action_controller'
require 'rails/railtie'
require 'i18n'

ENV['RAILS_ENV'] = 'test'

require 'desponders'

# Prevent deprecation warning
I18n.enforce_available_locales = false

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end
