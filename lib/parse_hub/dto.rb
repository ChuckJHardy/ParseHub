require 'parse_hub/api'

class ParseHub
  class DTO
    attr_reader :options

    def initialize(options:)
      @options = options
    end

    def self.get(options = {})
      new(options: options).response(:get)
    end

    def self.post(options = {})
      new(options: options).response(:post)
    end

    def response(method)
      API.public_send(
        method,
        domain: domain,
        url: endpoint,
        options: params
      ).body
    end

    def params
      {}
    end

    def domain
      fail NotImplementedError, 'Inheriting class must implement'
    end

    def endpoint
      fail NotImplementedError, 'Inheriting class must implement'
    end
  end
end
