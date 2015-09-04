require 'parse_hub/dto'

class ParseHub
  class Ask < DTO
    def self.for(options)
      new(options: options).response(:post)
    end

    def endpoint
      "/run"
    end

    private

    def params
      {
        start_url: url,
        start_template: template
      }
    end

    def url
      URI.escape(options.fetch(:url))
    end

    def template
      options.fetch(:template)
    end
  end
end
