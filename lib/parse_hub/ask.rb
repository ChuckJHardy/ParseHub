require 'parse_hub/dto'

class ParseHub
  class Ask < DTO
    def self.for(options)
      new(options: options).for
    end

    def for
      response(:post).fetch(:run_token)
    end

    def endpoint
      "projects/#{project_key}/run"
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

    def project_key
      options.fetch(:project_key)
    end
  end
end
