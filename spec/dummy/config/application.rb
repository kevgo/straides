require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(test)))
end

module Dummy
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.assets.enabled = true
    config.assets.version = '1.0'
  end
end

