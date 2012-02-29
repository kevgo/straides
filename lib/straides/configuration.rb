module Straides

  class Configuration

    def initialize

      # Whether to auto-include the Straides config into every controller.
      @auto_load = true
    end

    attr_accessor :auto_load

    # Returns the singleton instance of this Configuration class,
    # to be used for configuring the Rails app that uses this gem.
    def self.instance
      @__instance__ ||= new
    end
  end

  # Helper method for configuring Straides in an initializer file.
  #
  # Example:
  #   Straides::Configuration.configure do |config|
  #     config.auto_load = false
  #   end
  def self.configure
    raise RuntimeError("ERROR: You must provide a block to Straides.configure.") unless block_given?
    yield Configuration.instance
  end
end
