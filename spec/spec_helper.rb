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

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
#  config.use_transactional_fixtures = true
end
