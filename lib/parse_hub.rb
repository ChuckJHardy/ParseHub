require 'parse_hub/error'

class ParseHub
  ServiceDownError = Class.new(Error)
  UnauthorizedError = Class.new(Error)
  BadRequest = Class.new(Error)
end
