require 'spec_helper'

describe CoCpusController do

  #Delete these examples and add some real ones
  it "should use CoCpusController" do
    controller.should be_an_instance_of(CoCpusController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      mock_co_cpu = mock_model(CoCpu, :name => 'Paula')
      CoCpu.should_receive(:find).and_return(mock_co_cpu)
      get 'show', :id => '1'
      response.should be_success
    end
  end
end
