require 'bundler/setup'
require 'webmock/rspec'
require 'yaml'
require 'coveralls'
require 'simplecov'
require 'sesame'

Coveralls.wear!
SimpleCov.start do
  add_filter '/spec/'
end
Dir['./lib/**/*.rb'].each { |f| load f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

require 'pry-byebug'

def stub_fixtures(*args)
  args.each do |name|
    fixture_file = File.expand_path("../fixtures/#{name}.yaml", __FILE__)
    fixtures = YAML.safe_load(File.read(fixture_file), [Symbol])
    fixtures.each_value do |fixture|
      fill_response_headers(fixture[:response])
      stub_request(fixture[:method] || :get, "https://api.candyhouse.co/v1/#{fixture[:path]}")
        .with(fixture[:request])
        .to_return(fixture[:response])
    end
  end
end

def fill_response_headers(response)
  response[:headers] ||= {}
  response[:headers]['Content-Type'] ||= 'application/json'
  response[:headers]['Content-Length'] ||= response[:body].to_s.length
end
