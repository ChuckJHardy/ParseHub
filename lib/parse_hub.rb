require 'parse_hub/configuration'
require 'parse_hub/error'

class ParseHub
  extend Configure

  ServiceDownError = Class.new(Error)
  UnauthorizedError = Class.new(Error)
  BadRequest = Class.new(Error)
end
