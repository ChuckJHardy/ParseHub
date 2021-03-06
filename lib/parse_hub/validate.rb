class ParseHub
  class Validate
    def initialize(method:, domain:, url:, options:, response:)
      @method = method
      @domain = domain
      @url = url
      @options = options
      @response = response
    end

    def self.with(*args)
      new(*args).validate
    end

    def validate
      log

      # rubocop:disable Style/RaiseArgs
      fail BadResponse.new(error_args) if bad_response?
      fail BadRequest.new(error_args) if bad_request?
      fail NotFound.new(error_args) if not_found?
      fail ServiceDownError.new(error_args) if down?
      fail UnauthorizedError.new(error_args) if unauthorised?
      # rubocop:enable Style/RaiseArgs

      true
    end

    private

    attr_reader :response

    def error_args
      {
        domain: @domain,
        url: @url,
        options: @options,
        status: response.status,
        body: response.body
      }
    end

    def bad_response?
      response.body.is_a?(String)
    end

    def down?
      response.status == 504
    end

    def not_found?
      response.status == 404
    end

    def bad_request?
      response.status == 400
    end

    def unauthorised?
      response.status == 401
    end

    def log
      ParseHub.configuration.logger.info(
        "-> ParseHub Response: #{@method.upcase}\n#{error_args}"
      ) if ParseHub.configuration.log
    end
  end
end
