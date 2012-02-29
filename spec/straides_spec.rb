require 'spec_helper'

describe Straides do
  class TestController
  end

  describe "including the Straides gem into a controller" do
    it "includes the 'rescue_from' block" do
      TestController.should_receive(:rescue_from).once.with(Straides::ReturnHttpCodeError, :with => :show_error)
      TestController.send :include, Straides
    end
  end

  context "after the gem in included in a controller" do
    let(:controller) { TestController.new }

    describe "the controller now has Straides' error instance methods" do
      it "has the 'error' method" do
        controller.should respond_to :error
      end

      it "has the 'show_error' method" do
        controller.should respond_to :show_error
      end
    end

    describe "#error" do
      it "raises an ReturnHttpCodeError" do
        controller.should_receive(:raise).with(Straides::ReturnHttpCodeError, anything)
        controller.send(:error, 123)
      end

      it "adds the given status code to the given render options" do
        controller.should_receive(:raise).with(Straides::ReturnHttpCodeError, hash_including(:status => 123))
        controller.send(:error, 123)
      end

      it "forwards any other given render options to the raised error object" do
        controller.should_receive(:raise).with(Straides::ReturnHttpCodeError, hash_including(:text => 'my error text', :foo => 'bar'))
        controller.send(:error, 123, :text => 'my error text', :foo => 'bar')
      end
    end

    describe "#show_error" do
      after :each do
        controller.send(:show_error, @error)
      end

      it "should work with rails error code aliases" do
        @error = Straides::ReturnHttpCodeError.new :status => :not_found, :text => "foobar"
        controller.should_receive(:render).once.with(:status => :not_found, :text => "foobar")
      end

      it "should render nothing if only a status is provided" do
        @error = Straides::ReturnHttpCodeError.new :status => :not_found
        controller.should_receive(:render).once.with(:status => :not_found, :nothing => true)
      end

      it "renders the given text" do
        @error = Straides::ReturnHttpCodeError.new :text => 'error'
        controller.should_receive(:render).once.with(:text => 'error')
      end

      it "renders the given json data structure" do
        @error = Straides::ReturnHttpCodeError.new :json => {:foo => 'bar'}
        controller.should_receive(:render).once.with(:json => {:foo => 'bar'})
      end

      it "renders nothing if that is explicitely requested" do
        @error = Straides::ReturnHttpCodeError.new :nothing => true
        controller.should_receive(:render).once.with(:nothing => true)
      end

      context "default behavior when there is no output specified" do
        before { @error = Straides::ReturnHttpCodeError.new :status => 123 }

        context "while serving an HTML request" do
          before { controller.stub_chain("request.format.html?").and_return(true) }

          it "renders the corresponding error file in the 'public' directory" do
            controller.should_receive(:render).once.with(hash_including(:file => 'public/123'))
          end
          it "adds the 'html' format" do
            controller.should_receive(:render).once.with(hash_including(:formats => [:html]))
          end
        end

        context "while serving another type of request" do
          before { controller.stub_chain("request.format.html?").and_return(false) }
          it "returns an empty response body" do
            controller.should_receive(:render).once.with(hash_including(:nothing => true))
          end
        end
      end
    end
  end
end
