require 'parse_hub/configuration'
require 'parse_hub/error'
require 'parse_hub/ask'

class ParseHub
  extend Configure

  ServiceDownError = Class.new(Error)
  UnauthorizedError = Class.new(Error)
  BadRequest = Class.new(Error)
  MissingRunToken = Class.new(Error)

  def self.run(url:, template:)
    Ask.for(url: url, template: template)
  end
end
