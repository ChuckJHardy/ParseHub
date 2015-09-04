class ParseHub
  class Error < StandardError
    attr_reader :domain, :url, :options, :status, :body

    def initialize(domain:, url:, options:, status:, body:)
      @domain = domain
      @url = url
      @options = options
      @status = status
      @body = body
    end

    def message
      {
        domain: domain,
        url: url,
        options: options,
        response: {
          status: status,
          body: body
        },
      }
    end
  end
end
