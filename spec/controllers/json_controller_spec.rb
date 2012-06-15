require 'spec_helper'

describe JsonController do
  render_views

  describe "error code" do
    it 'returns the given error code' do
      get :code, :format => 'json'
      response.status.should == 401
    end
  end

  describe 'error message' do

    describe 'default behavior' do
      it 'renders an empty response' do
        get :code, :format => 'json'
        response.body.strip.should == ''
      end
    end

    context ':text given' do
      it 'renders the given string as the response text' do
        get :text, :format => 'json'
        response.body.should == 'descriptive error message'
      end
    end

    context ':nothing given' do
      it 'renders an empty response' do
        get :nothing, :format => 'json'
        response.body.strip.should == ''
      end
    end
  end
end

