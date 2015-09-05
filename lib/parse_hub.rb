require 'parse_hub/configuration'
require 'parse_hub/error'
require 'parse_hub/ask'
require 'parse_hub/answer'
require 'parse_hub/run'

class ParseHub
  extend Configure

  ServiceDownError = Class.new(Error)
  UnauthorizedError = Class.new(Error)
  BadRequest = Class.new(Error)
  MissingRunToken = Class.new(Error)

  def initialize(token:)
    @token = token
  end

  def self.run(url:, template:)
    Ask.for(url: url, template: template)
  end

  def answer
    Answer.for(token: token)
  end

  def finished?
    get.fetch(:status, '').include?('complete')
  end

  def get
    Run.for(token: token)
  end

  private

  attr_reader :token
end
