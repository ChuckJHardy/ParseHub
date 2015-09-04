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
      "#{base_url}/projects/#{project_key}"
    end

    def base_url
      ParseHub.configuration.base_url
    end

    def project_key
      ParseHub.configuration.project_key
    end

    def api_key
      ParseHub.configuration.api_key
    end
  end
end
