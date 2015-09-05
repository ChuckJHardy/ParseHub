require 'simplecov'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'parse_hub'

ParseHub.configure do |config|
  config.api_key = ENV['PARSE_HUB_API_KEY']
  config.project_key = ENV['PARSE_HUB_PROJECT_KEY']
  config.clean = true
  config.verbose = true
end

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.order = :random

  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end
