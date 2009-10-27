require 'spec_helper'

module PeripheralsControllerHelper
  def mock_peripheral(options={})
    @mock ||= mock_model(Peripheral, options)
  end
end

describe Admin::PeripheralsController do
  include PeripheralsControllerHelper
  
  describe 'NOT BEING LOGGED IN' do
    should_flash_and_redirect_for(
      :new => :get,
      :edit => :get,
      :index => :get,
      :create => :post,
      :update => :put,
      :destroy => :delete
    )
  end
  
  describe 'BEING LOGGED IN' do
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
      
      it 'should render index template' do
        response.should render_template(:index)
      end
      
      it 'should assign @peripherals' do
        assigns[:peripherals].should_not be_nil
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
      
      it 'should assign @peripheral' do
        assigns[:peripheral].should be_new_record
      end
    end
    
    describe 'GET EDIT' do
      before do
        Peripheral.should_receive(:find).and_return(mock_peripheral)
        get :edit, :id => '1'
      end
      
      it 'should be success' do
        response.should be_success
      end
      
      it 'should assign @peripheral' do
        assigns[:peripheral].should_not be_nil
      end
      
      it 'should render edit template' do
        response.should render_template(:edit)
      end
    end
    
    describe 'POST CREATE' do
      describe 'with valid attributes' do
        before do
          Peripheral.should_receive(:new).and_return(mock_peripheral(:save => true))
          post :create, :peripheral => {}
        end
        
        it 'should redirect to edit page' do
          response.should redirect_to(edit_admin_peripheral_path(mock_peripheral))
        end
        
        it 'should flash[:notice]' do
          flash[:notice].should =~ /successfully created/
        end
        
        it 'should assign @peripheral' do
          assigns[:peripheral].should_not be_nil
        end
      end
      
      describe 'with invalid attributes' do
        before do
          Peripheral.should_receive(:new).and_return(mock_peripheral(:save => false))
          post :create, :peripheral => {}
        end
        
        it 'should be success' do
          response.should be_success
        end
        
        it 'should render new template' do
          response.should render_template(:new)
        end
        
        it 'should not flash' do
          flash[:notice].should be_nil
        end
        
        it 'should assign @peripheral' do
          assigns[:peripheral].should_not be_nil
        end
      end
    end
    
    describe 'PUT UPDATE' do
      describe 'with valid attributes' do
        before do
          Peripheral.should_receive(:find).and_return(mock_peripheral(:update_attributes => true))
          put :update, :id => '1', :peripheral => {}
        end
        
        it 'should redirect to edit template' do
          response.should redirect_to(edit_admin_peripheral_path(mock_peripheral))
        end
        
        it 'should flash' do
          flash[:notice].should =~ /successfully updated/
        end
        
        it 'should assign @peripheral' do
          assigns[:peripheral].should_not be_nil
        end
      end
      
      describe 'with invalid attributes' do
        before do
          Peripheral.should_receive(:find).and_return(mock_peripheral(:update_attributes => false))
          put :update, :id => '1', :peripheral => {}
        end
  
        it 'should be success' do
          response.should be_success
        end
  
        it 'should render edit template' do
          response.should render_template(:edit)
        end
  
        it 'should not flash' do
          flash[:notice].should be_nil
        end
  
        it 'should assign @peripheral' do
          assigns[:peripheral].should_not be_nil
        end
      end
    end
    
    describe 'DELETE DESTROY' do
      before do
        Peripheral.should_receive(:find).and_return(mock_peripheral)
        mock_peripheral.should_receive(:destroy)
        delete :destroy, :id => '1'
      end
      
      it 'should redirect to peripherals page' do
        response.should redirect_to(admin_peripherals_path)
      end
      
      it 'should flash[:notice]' do
        flash[:notice].should_not be_nil
      end
    end
  end
end
