require "rails/railtie"

module Straides

  class Railtie < Rails::Railtie

    # Initialize Straides after the Rails initializers have run.
    config.after_initialize do
      if Straides::Configuration.instance.auto_load
        # Note (KG): Including Straides into ActionController::Base here doesn't work in unit tests.
        ApplicationController.send :include, Straides
      end
    end
  end

end
