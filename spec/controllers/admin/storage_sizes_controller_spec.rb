require 'spec_helper'

module StorageSizesControllerHelper
  def post_create
    post :create, :storage_size => {}
  end

  def mock_storage_size(options={})
    mock_model(StorageSize, options)
  end
end

describe Admin::StorageSizesController do
  include StorageSizesControllerHelper
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

      it 'should assign @storage_sizes' do
        assigns[:storage_sizes].should_not be_nil
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

      it 'should assign @storage_size' do
        assigns[:storage_size].should_not be_nil
      end

      it 'should assign a new record to @storage_size' do
        assigns[:storage_size].should be_new_record
      end
    end

    describe 'POST CREATE' do
      describe 'with valid attributes' do
        before do
          StorageSize.should_receive(:new).and_return(mock_storage_size(:save => true))
          post_create
        end

        it 'should flash' do
          flash[:notice].should == 'Storage size was successfully created.'
        end

        it 'should redirect to admin_storage_sizes_path' do
          response.should redirect_to(admin_storage_sizes_path)
        end

        it 'should assign @storage_size' do
          assigns[:storage_size].should_not be_nil
        end
      end

      describe 'with invalid attributes' do
        before do
          StorageSize.should_receive(:new).and_return(mock_storage_size(:save => false))
          post_create
        end
        it 'should render new template' do
          response.should render_template(:new)
        end

        it 'should assign @storage_size' do
          assigns[:storage_size].should_not be_nil
        end
      end
    end

    describe 'DELETE DELETE' do
    # il classico metodo destroy è stato sostituito da questo delete che opera
    # attraverso un form che posta gli id. Tutto sto casino è per non avere negli url
    # l'id con il punto, visto che rails lo interpreta come separatore per format
    
      before do
        StorageSize.should_receive(:find).with('1.2Mb').and_return(mock_storage_size(:destroy => nil))
        delete :delete, :id => '1.2Mb'
      end

      it 'should flash' do
        flash[:notice].should == 'Storage size was successfully destroyed.'
      end

      it 'should redirect to admin_storage_sizes_path' do
        response.should redirect_to(admin_storage_sizes_path)
      end
    end
  end
end