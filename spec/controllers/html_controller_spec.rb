require 'spec_helper'

describe HtmlController do
  render_views

  describe "error code" do
    it 'returns the given error code' do
      get :code
      response.status.should == 401
    end

    context 'symbol given' do
      it 'returns the proper error code' do
        get :symbol
        response.status.should == 404
      end
    end
  end

  describe 'error message' do

    describe 'default behavior' do
      it 'renders the file corresponding to the error code in the /public directory' do
        get :code
        response.body.strip.should == 'Content of the public/401.html file.'
      end
      context 'symbol error code given' do
        it 'renders the file corresponding to the given symbolic error code' do
          get :symbol
          response.body.strip.should == 'Content of the public/404.html file.'
        end
      end
    end

    context ':text given' do
      it 'renders the given string as the response text' do
        get :text
        response.body.should == 'descriptive error message'
      end
    end

    context ':nothing given' do
      it 'renders an empty response' do
        get :nothing
        response.body.strip.should == ''
      end
    end

  end
end

