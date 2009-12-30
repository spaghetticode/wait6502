require 'spec_helper'

describe PeripheralsController do
  def mock_hardware(options={})
    @hardware ||= mock_model(Hardware, {:name => 'DuoDisk'}.merge(options))
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      Hardware.should_receive(:find).and_return(mock_hardware)
      get 'show', :id => mock_hardware.to_param
      response.should be_success
    end
    
    it 'should redirect' do
      Hardware.should_receive(:find).and_return(mock_hardware)
      get 'show', :id => mock_hardware.to_param + 'foo'
      response.should redirect_to peripheral_path(mock_hardware)
    end
  end
end
