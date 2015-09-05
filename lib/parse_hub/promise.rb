class ParseHub
  class Promise
    RESCUE_WAIT = 5

    def initialize(waits:, trys:, answer:, finished:, delete:)
      @waits = waits
      @trys = trys
      @answer = answer
      @finished = finished
      @delete = delete
    end

    def self.run(*args, &block)
      new(*args).run(&block)
    end

    def run(&block) # rubocop:disable Metrics/MethodLength
      current = 1

      while current <= @trys
        if @finished.call
          block.call(@answer.call)
          delete
          break
        end

        sleep(@waits.shift || RESCUE_WAIT)

        current += 1
      end

      fail ParseHub::RunLoopsError, @trys if current > @trys
    end

    private

    def delete
      @delete.call if clean?
    end

    def clean?
      ParseHub.configuration.clean
    end
  end
end
