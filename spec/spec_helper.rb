require 'coveralls'
Coveralls.wear!


require 'rubygems'
require 'bundler/setup'
require 'rails'
require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'rspec'
require 'rspec/rails'
require 'straides'

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

RSpec.configure do |config|
  config.mock_with :rspec
  #  config.use_transactional_fixtures = true
end
