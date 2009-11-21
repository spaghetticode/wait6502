require 'spec_helper'

describe CpusController do

  #Delete these examples and add some real ones
  it "should use CpusController" do
    controller.should be_an_instance_of(CpusController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      mock_cpu = mock_model(Cpu, :name => 'Motorola 68000')
      Cpu.should_receive(:find).and_return(mock_cpu)
      get 'show', :id => '1'
      response.should be_success
    end
  end
end
