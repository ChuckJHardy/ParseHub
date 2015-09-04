require 'spec_helper'

require 'vcr'
require 'webmock'

ParseHub.configure do |config|
  config.api_key = ENV['PARSE_HUB_API_KEY']
  config.project_key = ENV['PARSE_HUB_PROJECT_KEY']
  config.clean = true
  config.verbose = true
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock
end
