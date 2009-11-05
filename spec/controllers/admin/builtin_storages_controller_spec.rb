require 'spec_helper'

module BuiltinStoragesControllerHelper
  def post_create
    post :create, :builtin_storage => {}
  end
  
  def delete_destroy
    delete :destroy, :id => '1'
  end
  
  def mock_builtin_storage(options={})
    @mock ||= mock_model(BuiltinStorage, options)
  end
end

describe Admin::BuiltinStoragesController do
  include BuiltinStoragesControllerHelper
  
  describe 'WITHOUT BEING AUTHENTICATED' do
    should_flash_and_redirect_for(
      :new => :get,
      :index => :get,
      :edit => :get,
      :create => :post,
      :update => :put,
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
    
      it 'should assign @builtin_storages' do
        assigns[:builtin_storages].should_not be_nil
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
    
      it 'should assign @builtin_storage' do
        assigns[:builtin_storage].should_not be_nil
      end
    
      it 'should assign a new record to @builtin_storage' do
        assigns[:builtin_storage].should be_new_record
      end
    end
    
    describe 'GET EDIT' do
      before do
        BuiltinStorage.should_receive(:find).and_return(mock_builtin_storage)
        get :edit, :id => '1'
      end
      
      it 'should be success' do
        response.should be_success
      end
      
      it 'should render edit template' do
        response.should render_template(:edit)
      end
      
      it 'should assign @builtin_storage' do
        assigns[:builtin_storage].should_not be_nil
      end
    end
    
    describe 'POST CREATE' do
      describe 'with valid attributes' do
        before do
          BuiltinStorage.should_receive(:new).and_return(mock_builtin_storage(:save => true))
          post_create
        end
      
        it 'should flash' do
          flash[:notice].should == 'Builtin storage was successfully created.'
        end
      
        it 'should redirect to admin_builtin_storages_path' do
          response.should redirect_to(admin_builtin_storages_path)
        end
      
        it 'should assign @builtin_storage' do
          assigns[:builtin_storage].should_not be_nil
        end
      end
    
      describe 'with invalid attributes' do
        before do
          BuiltinStorage.should_receive(:new).and_return(mock_builtin_storage(:save => false))
          post_create
        end
        it 'should render new template' do
          response.should render_template(:new)
        end
      
        it 'should assign @builtin_storage' do
          assigns[:builtin_storage].should_not be_nil
        end
      end
    end
  
    describe 'DELETE DESTROY' do
      describe 'when builtin storage has no hardware associated' do
        before do
          BuiltinStorage.should_receive(:find).and_return(mock_builtin_storage(:hardware => []))
          mock_builtin_storage.should_receive(:destroy)
          delete_destroy
        end
    
        it 'should flash with a success message' do
          flash[:notice].should == 'Builtin storage was successfully destroyed.'
        end
    
        it 'should redirect to admin_builtin_storages_path' do
          response.should redirect_to(admin_builtin_storages_path)
        end
      end
      
      describe 'when builtin storage has at least one hardware associated' do
        before do
          BuiltinStorage.should_receive(:find).and_return(mock_builtin_storage(:hardware => [mock_model(Hardware)]))
          mock_builtin_storage.should_not_receive(:destroy)
          delete_destroy
        end
        
        it 'should redirect to admin_builtin_storages_path' do
          response.should redirect_to(admin_builtin_storages_path)
        end
        
        it 'should flash with a error message' do
          flash[:error].should_not be_nil
        end
      end
    end
  end
end
