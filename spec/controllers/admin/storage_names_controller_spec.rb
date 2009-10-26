require 'spec_helper'

module StorageNamesControllerHelper
  def post_create
    post :create, :storage_name => {}
  end

  def mock_storage_name(options={})
    @mock ||= mock_model(StorageName, options)
  end
end

describe Admin::StorageNamesController do
  include StorageNamesControllerHelper
  
  describe 'WITHOUT BEING AUTHENTICATED' do
    should_flash_and_redirect_for(
      :new => :get,
      :index => :get,
      :create => :post,
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

      it 'should render new template' do
        response.should render_template(:index)
      end

      it 'should assign @storage_names' do
        assigns[:storage_names].should_not be_nil
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

      it 'should assign @storage_name' do
        assigns[:storage_name].should_not be_nil
      end

      it 'should assign a new record to @storage_name' do
        assigns[:storage_name].should be_new_record
      end
    end

    describe 'POST CREATE' do
      describe 'with valid attributes' do
        before do
          StorageName.should_receive(:new).and_return(mock_storage_name(:save => true))
          post_create
        end

        it 'should flash' do
          flash[:notice].should == 'Storage name was successfully created.'
        end

        it 'should redirect to admin_storage_names_path' do
          response.should redirect_to(admin_storage_names_path)
        end

        it 'should assign @storage_name' do
          assigns[:storage_name].should_not be_nil
        end
      end

      describe 'with invalid attributes' do
        before do
          StorageName.should_receive(:new).and_return(mock_storage_name(:save => false))
          post_create
        end
        it 'should render new template' do
          response.should render_template(:new)
        end

        it 'should assign @storage_name' do
          assigns[:storage_name].should_not be_nil
        end
      end
    end

    describe 'DELETE DESTROY' do
      describe 'when storage name is not part of any builtin storage' do
        before do
          BuiltinStorage.should_receive(:find_by_storage_name_id).and_return(nil)
          StorageName.should_receive(:find).and_return(mock_storage_name)
          mock_storage_name.should_receive(:destroy)
          delete :destroy, :id => '1'
        end

        it 'should flash' do
          flash[:notice].should == 'Storage name was successfully destroyed.'
        end

        it 'should redirect to admin_storage_names_path' do
          response.should redirect_to(admin_storage_names_path)
        end
      end
      
      describe 'when storage name is part of at least one builtin storage' do
        before do
          BuiltinStorage.should_receive(:find_by_storage_name_id).and_return(mock_model(BuiltinStorage))
          StorageName.should_not_receive(:find)
          delete :destroy, :id => '1'
        end
        
        it 'should flash[:error]' do
          flash[:error].should_not be_nil
        end
        
        it 'should redirect to admin_storage_names_path' do
          response.should redirect_to(admin_storage_names_path)
        end      
      end
    end
  end
end