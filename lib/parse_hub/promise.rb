class ParseHub
  class Promise
    def initialize(wait:, trys:, answer:, finished:, delete:)
      @wait = wait
      @trys = trys
      @answer = answer
      @finished = finished
      @delete = delete
    end

    def self.run(*args, &block)
      new(*args).run(&block)
    end

    def run(&block)
      current = 1

      while current <= @trys
        puts 'face'
        if @finished.call
          block.call(@answer.call)
          delete
          break
        end

        wait

        current += 1
      end

      fail ParseHub::RunLoopsError, @trys if current > @trys
    end

    private

    def delete
      @delete.call if clean?
    end

    def wait
      sleep(@wait)
    end

    def clean?
      ParseHub.configuration.clean
    end
  end
end
