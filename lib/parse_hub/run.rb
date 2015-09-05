require 'parse_hub/dto'

class ParseHub
  class Run < DTO
    def self.for(options)
      new(options: options).response(options.fetch(:method, :get))
    end

    def endpoint
      "runs/#{token}"
    end

    private

    def token
      options.fetch(:token)
    end
  end
end
