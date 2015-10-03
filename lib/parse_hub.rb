require 'logger'

require 'parse_hub/configuration'
require 'parse_hub/error'
require 'parse_hub/ask'
require 'parse_hub/answer'
require 'parse_hub/run'
require 'parse_hub/promise'

class ParseHub
  extend Configure

  WAITS = [5, 5, 2, 1, 3]
  TRYS = 5

  ServiceDownError = Class.new(Error)
  UnauthorizedError = Class.new(Error)
  BadResponse = Class.new(Error)
  BadRequest = Class.new(Error)
  NotFound = Class.new(Error)
  MissingRunToken = Class.new(StandardError)
  RunLoopsError = Class.new(StandardError)

  attr_reader :token

  def initialize(token:)
    validate_token(token)
    @token = token
  end

  def self.run(project_key:, url:, template:)
    Ask.for(project_key: project_key, url: url, template: template)
  end

  def promise(waits: WAITS, trys: TRYS, &block)
    Promise.run(
      waits: waits,
      trys: trys,
      answer: -> { answer },
      finished: -> { finished? },
      delete: -> { delete },
      &block
    )
  end

  def answer
    Answer.for(token: token)
  end

  def finished?
    get.fetch(:status, '').include?('complete')
  end

  def get
    @get ||= Run.for(token: token, method: :get)
  end

  def delete
    Run.for(token: token, method: :delete).fetch(:run_token, '')
  end

  def validate_token(str)
    fail MissingRunToken, str.inspect if str.to_s.empty?
  end
end
