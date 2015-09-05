# ParseHub - [ ![Codeship Status for ChuckJHardy/ParseHub](https://codeship.com/projects/d4ebc830-35e7-0133-2e9b-0e2f5121d0d5/status?branch=master)](https://codeship.com/projects/100845)

Wrapper for ParseHub API

## Installation

Add this line to your application's Gemfile:

    gem 'parse_hub', github: 'ChuckJHardy/ParseHub'

And then execute:

    $ bundle

## Configuration

    ParseHub.configure do |config|
      config.base_url = "https://www.parsehub.com/api/v3"
      config.api_key = "pol6BFzsASYw4gQBl02b24nt"
      config.project_key = "tn42b20lBQg4wYSAszFB6lop"
      config.clean = true
      config.verbose = true
      config.log = true
      config.logger = Rails.logger
    end

* `base_url` sets the ParseHub API url `https://www.parsehub.com/api/v2`
* `api_key` sets the ParseHub API Key `nil`
* `project_key` sets the ParseHub Project Key `nil`
* `clean` removes each run when complete `false`
* `verbose` should all output be printed to STDOUT `false`
* `log` should log message be logged `false`
* `logger` Logger object. `Logging::Logger`

Default Logger: https://github.com/TwP/logging

## Usage

Find Exchange Rate:

    token = ParseHub.run(url: 'http://google.com', template: 'google')
    # => tn42b20lBQg4wYSAszFB6lop

    ph = ParseHub.new(token: token)
    ph.answer
    # => { ... }

    ph.finished?
    # => true

    ph.delete
    # => true

    waits = [10, 2, 1, 1, 1] # Each time you can wait for a different period. Defaults to 5
    ph.promise(token: token, waits: waits, trys: 5) do |response|
      puts response.inspect #=> { ... }
    end

## Testing

Ensure `PARSE_HUB_API_KEY` and `PARSE_HUB_PROJECT_KEY` environment variable is set when recording VCR cassettes.

    # Includes Rubocop
    $ bin/rspec

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ParseHub/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
