require 'spec_helper'

describe ComputersController do
  describe 'get index' do
    before do
      get :index
    end
    
    it 'should be success' do
      response.should be_success
    end
  end
  
  describe 'get show' do
    before do
      Hardware.should_receive(:find)
      get :show, :id => '1'
    end
    
    it 'should be success' do
      response.should be_success
    end
  end
end
