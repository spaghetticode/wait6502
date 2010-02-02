require 'spec_helper'

describe HardwareController do
  def mock_computer(options={})
    @mock ||= mock_model(Hardware, options)
  end
  
  def mock_letter(options={})
    hardware = [mock_computer]
    peripherals = []
    peripherals.stub!(:by_manufacturer => [])
    hardware.stub!(
      :computer => hardware,
      :peripheral => peripherals,
      :by_manufacturer => hardware
    )
    @letter ||= mock_model(Letter, {:hardware => hardware, :name => name}.merge!(options))
  end
  
  describe 'get index' do
    before do
      Letter.should_receive(:find_by_name).and_return(mock_letter)
      get :index
    end
    
    it 'should be success' do
      response.should be_success
    end
  end
  
  describe 'get show' do
    describe 'when param matches computer permalink field value' do
      before do
        Hardware.should_receive(:find).and_return(mock_computer)
        get :show, :id => mock_computer.to_param
      end
    
      it 'should be success' do
        response.should be_success
      end
    end
  end
  
  describe 'when param doesnt match computer permalink field value' do
    before do
      Hardware.should_receive(:find).and_return(mock_computer)
      get :show, :id => mock_computer.to_param + 'foo'
    end
    
    it 'should redirect' do
      response.should be_redirect
    end
    
    it 'should redirect to same computer path' do
      response.should redirect_to(hardware_path(mock_computer))
    end
  end
end
