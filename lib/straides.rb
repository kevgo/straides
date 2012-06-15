require 'active_support/concern'
require 'rack'
require 'straides/configuration'
require 'straides/railtie'
require 'straides/return_http_code_error'
require 'straides/version'

module Straides
  extend ActiveSupport::Concern

  included do
    rescue_from ReturnHttpCodeError, :with => :show_error


    protected

    # Makes the current action abort and return an HTTP error.
    #
    # @param [ Integer ] status
    # @param [ Hash ] render_options
    def error status, render_options = {}
      render_options[:status] = status
      raise ReturnHttpCodeError, render_options
    end

    # Outputs the given error to the client.
    #
    # @param [ Straides::ReturnHttpCodeError ] error
    def show_error error
      unless error.has_template?
        if request.send(:format).html?
          status_code = error.render_options[:status]
          status_code = Rack::Utils.status_code(error.render_options[:status]) if status_code.is_a?(Symbol)
          error.render_options[:file] = "public/#{status_code}"
          error.render_options[:formats] = [:html]
        else
          error.render_options[:nothing] = true
        end
      end
      render error.render_options
    end
  end
end
