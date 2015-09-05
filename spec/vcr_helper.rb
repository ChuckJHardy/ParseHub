require 'spec_helper'

require 'vcr'
require 'webmock'

RSpec.configure do |config|
  config.before do
    ParseHub.configuration.api_key = ENV['PARSE_HUB_API_KEY']
    ParseHub.configuration.project_key = ENV['PARSE_HUB_PROJECT_KEY']
  end

  config.after do
    ParseHub.configuration.api_key = nil
    ParseHub.configuration.project_key = nil
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock

  c.filter_sensitive_data('<PARSE_HUB_API_KEY>') do
    ENV['PARSE_HUB_API_KEY']
  end

  c.filter_sensitive_data('<PARSE_HUB_PROJECT_KEY>') do
    ENV['PARSE_HUB_PROJECT_KEY']
  end
end
