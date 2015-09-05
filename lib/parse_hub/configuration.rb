class ParseHub
  module Configure
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
      configuration
    end

    private

    class Configuration
      attr_accessor :base_url,
                    :api_key,
                    :project_key,
                    :clean,
                    :verbose,
                    :log,
                    :logger

      def initialize
        self.base_url = 'https://www.parsehub.com/api/v2/'
        self.api_key = nil
        self.project_key = nil
        self.clean = false
        self.verbose = false
        self.log = false
        self.logger = Logger.new(STDOUT)
      end
    end
  end
end
