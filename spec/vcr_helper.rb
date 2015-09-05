require 'spec_helper'

require 'vcr'
require 'webmock'

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
