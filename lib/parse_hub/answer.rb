require 'parse_hub/dto'

class ParseHub
  class Answer < DTO
    def self.for(options)
      new(options: options).response(:get)
    end

    def endpoint
      "runs/#{token}/data"
    end

    private

    def token
      options.fetch(:token)
    end
  end
end
