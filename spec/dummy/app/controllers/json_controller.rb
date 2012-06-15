class JsonController < ApplicationController

  def code
    error 401
  end

  def text
    error 401, :text => 'descriptive error message'
  end

  def nothing
    error 401, :nothing => true
  end
end

