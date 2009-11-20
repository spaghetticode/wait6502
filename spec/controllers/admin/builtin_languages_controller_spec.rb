require 'spec_helper'

module BuiltinLanguagesControllerHelper
  def post_create
    post :create, :builtin_language => {}
  end
  
  def put_update
    put :update, :builtin_language => {}, :id => '1'
  end
  
  def delete_destroy
    delete :destroy, :id => 'BASIC'
  end
  
  def mock_builtin_language(options={})
    @mock ||= mock_model(BuiltinLanguage, options)
  end
end

describe Admin::BuiltinLanguagesController do
  include BuiltinLanguagesControllerHelper
  
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

      it 'should assign @builtin_languages' do
        assigns[:builtin_languages].should_not be_nil
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

      it 'should assign @builtin_language' do
        assigns[:builtin_language].should_not be_nil
      end

      it 'should assign a new record to @builtin_language' do
        assigns[:builtin_language].should be_new_record
      end
    end
    
    describe 'POST CREATE' do
      describe 'with valid attributes' do
        before do
          BuiltinLanguage.should_receive(:new).and_return(mock_builtin_language(:save => true))
          post_create
        end

        it 'should flash' do
          flash[:notice].should == 'Builtin language was successfully created.'
        end

        it 'should redirect to admin_builtin_languages_path' do
          response.should redirect_to(admin_builtin_languages_path)
        end

        it 'should assign @builtin_language' do
          assigns[:builtin_language].should_not be_nil
        end
      end

      describe 'with invalid attributes' do
        before do
          BuiltinLanguage.should_receive(:new).and_return(mock_builtin_language(:save => false))
          post_create
        end
        it 'should render new template' do
          response.should render_template(:new)
        end

        it 'should assign @builtin_language' do
          assigns[:builtin_language].should_not be_nil
        end
      end
    end

    describe 'DELETE DESTROY' do
      describe 'when builtin language has no hardware associated' do
        before do
          BuiltinLanguage.should_receive(:find_by_permalink).
            and_return(mock_builtin_language(:destroy => nil, :hardware => []))
          mock_builtin_language.should_receive(:destroy)
          delete_destroy
        end

        it 'should flash a success message' do
          flash[:notice].should == 'Builtin language was successfully destroyed.'
        end

        it 'should redirect to admin_builtin_languages_path' do
          response.should redirect_to(admin_builtin_languages_path)
        end
      end
      
      describe 'when builtin language has hardware associated' do
        before do
          BuiltinLanguage.should_receive(:find_by_permalink).
            and_return(mock_builtin_language(:hardware => [mock_model(Hardware)]))
          mock_builtin_language.should_not_receive(:destroy)
          delete_destroy
        end
        
        it 'should redirect to admin_builtin_languages_path' do
          response.should redirect_to(admin_builtin_languages_path)
        end
        
        it 'should flash a failure message' do
          flash[:error] = 'Can\'t destroy: language still has associated hardware'
        end
      end
    end
  end
end
