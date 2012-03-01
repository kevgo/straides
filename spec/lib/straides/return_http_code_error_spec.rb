require 'spec_helper'

describe Straides::ReturnHttpCodeError do
  describe 'has_template?' do
    it 'returns TRUE if the user has provided a :file option' do
      Straides::ReturnHttpCodeError.new(:file => 'foo').should have_template
    end
    it 'returns TRUE if the user has provided a :text option' do
      Straides::ReturnHttpCodeError.new(:text => 'foo').should have_template
    end
    it 'returns TRUE if the user has provided a :json option' do
      Straides::ReturnHttpCodeError.new(:json => {:foo => 'bar'}).should have_template
    end
    it 'returns TRUE if the user has provided a :nothing option' do
      Straides::ReturnHttpCodeError.new(:nothing => true).should have_template
    end
    it 'returns FALSE if no options are provided' do
      Straides::ReturnHttpCodeError.new({}).should_not have_template
    end
  end
end
