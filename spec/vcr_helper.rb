require 'spec_helper'

require 'vcr'
require 'webmock'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock
end
