require 'spec_helper'

module StorageFormatsControllerHelper
  def post_create
    post :create, :storage_format => {}
  end

  def mock_storage_format(options={})
    @mock ||= mock_model(StorageFormat, options)
  end
end

describe Admin::StorageFormatsController do
  include StorageFormatsControllerHelper
  
  describe 'WITHOUT BEING AUTHENTICATED' do
    should_flash_and_redirect_for(
      :new => :get,
      :index => :get,
      :create => :post,
      :delete => :delete
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

      it 'should assign @storage_formats' do
        assigns[:storage_formats].should_not be_nil
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

      it 'should assign @storage_format' do
        assigns[:storage_format].should_not be_nil
      end

      it 'should assign a new record to @storage_format' do
        assigns[:storage_format].should be_new_record
      end
    end

    describe 'POST CREATE' do
      describe 'with valid attributes' do
        before do
          StorageFormat.should_receive(:new).and_return(mock_storage_format(:save => true))
          post_create
        end

        it 'should flash' do
          flash[:notice].should == 'Storage format was successfully created.'
        end

        it 'should redirect to admin_storage_formats_path' do
          response.should redirect_to(admin_storage_formats_path)
        end

        it 'should assign @storage_format' do
          assigns[:storage_format].should_not be_nil
        end
      end

      describe 'with invalid attributes' do
        before do
          StorageFormat.should_receive(:new).and_return(mock_storage_format(:save => false))
          post_create
        end
        it 'should render new template' do
          response.should render_template(:new)
        end

        it 'should assign @storage_format' do
          assigns[:storage_format].should_not be_nil
        end
      end
    end

    describe 'DELETE DELETE' do
    # il classico metodo destroy è stato sostituito da questo delete che opera
    # attraverso un form che posta gli id. Tutto sto casino è per non avere negli url
    # l'id con il punto, visto che rails lo interpreta come separatore per format
      describe 'when storage format is not part of any builtin storage' do
        before do
          StorageFormat.should_receive(:find).with('3.5 inches').and_return(mock_storage_format)
          mock_storage_format.should_receive(:destroy)
          delete :delete, :id => '3.5 inches'
        end

        it 'should flash' do
          flash[:notice].should == 'Storage format was successfully destroyed.'
        end

        it 'should redirect to admin_storage_formats_path' do
          response.should redirect_to(admin_storage_formats_path)
        end
      end
      
      describe 'when storage format is part of at least one builtin storage' do
        before do
          BuiltinStorage.should_receive(:find_by_storage_format_id).and_return(mock_model(BuiltinStorage))
          StorageFormat.should_not_receive(:find)
          delete :delete, :id => '3.5 inches'
        end
        
        it 'should flash[:error]' do
          flash[:error].should_not be_nil
        end
        
        it 'should redirect to admin_storage_formats_path' do
          response.should redirect_to(admin_storage_formats_path)
        end
      end
    end
  end
end