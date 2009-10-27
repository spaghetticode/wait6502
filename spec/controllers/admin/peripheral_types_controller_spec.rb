require 'spec_helper'

module PeripheralTypesControllerHelper
  def mock_peripheral_type(options={})
    @mock ||= mock_model(PeripheralType, options)
  end
  
  def post_create
    post :create, :peripheral_type => {}
  end
end

describe Admin::PeripheralTypesController do
  include PeripheralTypesControllerHelper
  
  describe 'WITHOUT BEING AUTHENTICATED' do
    should_flash_and_redirect_for(
      :new => :get,
      :index => :get,
      :create => :post,
      :destroy => :delete
    )
  end
  
  describe 'BEING AUTHENTICATED' do
    before do
      activate_authlogic
      UserSession.create!(Factory(:user))
    end
    
    describe 'GET INDEX' do
      before do
        get :index
      end
    
      it 'should be success' do
        response.should be_success
      end
    
      it 'should render new template' do
        response.should render_template(:index)
      end
    
      it 'should assign @peripheral_types' do
        assigns[:peripheral_types].should_not be_nil
      end
    end
  
    describe 'GET NEW' do
      before do
        get :new
      end
    
      it 'should be success' do
        response.should be_success
      end
    
      it 'should render new template' do
        response.should render_template(:new)
      end
    
      it 'should assign @peripheral_type' do
        assigns[:peripheral_type].should_not be_nil
      end
    
      it 'should assign a new record to @peripheral_type' do
        assigns[:peripheral_type].should be_new_record
      end
    end
  
    describe 'POST CREATE' do
      describe 'with valid attributes' do
        before do
          PeripheralType.should_receive(:new).and_return(mock_peripheral_type(:save => true))
          post_create
        end
      
        it 'should flash' do
          flash[:notice].should == 'Peripheral type was successfully created.'
        end
      
        it 'should redirect to admin_peripheral_types_path' do
          response.should redirect_to(admin_peripheral_types_path)
        end
      
        it 'should assign @peripheral_type' do
          assigns[:peripheral_type].should_not be_nil
        end
      end
    
      describe 'with invalid attributes' do
        before do
          PeripheralType.should_receive(:new).and_return(mock_peripheral_type(:save => false))
          post_create
        end
        it 'should render new template' do
          response.should render_template(:new)
        end
      
        it 'should assign @peripheral_type' do
          assigns[:peripheral_type].should_not be_nil
        end
      end
    end
  
    describe 'DELETE DESTROY' do
      describe 'when peripheral type has no associated peripheral' do
        before do
          PeripheralType.should_receive(:find).and_return(mock_peripheral_type(:peripherals => []))
          mock_peripheral_type.should_receive(:destroy)
          delete :destroy, :id => '1'
        end
    
        it 'should flash' do
          flash[:notice].should == 'Peripheral type was successfully destroyed.'
        end
    
        it 'should redirect to admin_peripheral_types_path' do
          response.should redirect_to(admin_peripheral_types_path)
        end
      end
      
      describe 'when peripheral type has at least one peripheral associated' do
        before do
          Peripheral.should_receive(:find).and_return(mock_model(Peripheral))
          mock_peripheral_type.should_not_receive(:destroy)
          delete :destroy, :id => '1'
        end
        
        it 'should flash[:error]' do
          flash[:error].should_not be_nil
        end
        
        it 'should redirect to admin_peripheral_types_path' do
          response.should redirect_to(admin_peripheral_types_path)
        end
      end
    end
  end
end
