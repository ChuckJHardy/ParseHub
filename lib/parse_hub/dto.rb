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

    def self.delete(options = {})
      new(options: options).response(:delete)
    end

    def response(method)
      log(method: method)

      API.public_send(
        method,
        domain: domain,
        url: endpoint,
        options: {
          api_key: api_key,
          format: 'json'
        }.merge(params)
      ).body
    end

    def params
      {}
    end

    def endpoint
      fail NotImplementedError, 'Inheriting class must implement'
    end

    private

    def domain
      ParseHub.configuration.base_url
    end

    def api_key
      ParseHub.configuration.api_key
    end

    def log(method:)
      ParseHub.configuration.logger.info([
        "-> ParseHub Request: #{method.upcase}",
        "domain: #{domain}",
        "endpoint: #{endpoint}",
        "api_key: #{api_key}",
        "params: #{params}"
      ].join("\n")) if ParseHub.configuration.log
    end
  end
end
