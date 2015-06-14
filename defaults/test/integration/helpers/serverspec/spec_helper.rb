require 'serverspec'
require 'type/http_request'
require 'type/yaml_file'

# Required by serverspec
set :backend, :exec

RSpec.configure do |config|
  # Configure RSpec to accept only the new expectation syntax
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
