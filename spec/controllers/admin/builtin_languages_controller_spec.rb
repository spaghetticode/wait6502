require 'spec_helper'

module BuiltinLanguagesControllerHelper
  def post_create
    post :create, :builtin_language => {}
  end

  def delete_delete
    delete :delete, :id => 'BASIC'
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

    # il classico metodo destroy è stato sostituito da questo delete che opera
    # attraverso un form che posta gli id. Tutto sto casino è per non avere negli url
    # l'id con il punto, visto che rails lo interpreta come separatore per format'
    describe 'DELETE DELETE' do
      describe 'when builtin language has no computer associated' do
        before do
          BuiltinLanguage.should_receive(:find).with('BASIC').
            and_return(mock_builtin_language(:destroy => nil, :computers => []))
          # the following expectation should not be in a before block, as it tests
          # the real guts of the method but this makes specs code more readable
          # and in my opinion doesn't hurt that much
          mock_builtin_language.should_receive(:destroy)
          delete_delete
        end

        it 'should flash a success message' do
          flash[:notice].should == 'Builtin language was successfully destroyed.'
        end

        it 'should redirect to admin_builtin_languages_path' do
          response.should redirect_to(admin_builtin_languages_path)
        end
      end
      
      describe 'when builtin language has computers associated' do
        before do
          BuiltinLanguage.should_receive(:find).with('BASIC').
            and_return(mock_builtin_language(:computers => [mock_model(Computer)]))
          mock_builtin_language.should_not_receive(:destroy)
          delete_delete
        end
        
        it 'should redirect to admin_builtin_languages_path' do
          response.should redirect_to(admin_builtin_languages_path)
        end
        
        it 'should flash a failure message' do
          flash[:error] = 'Can\'t destroy: language still has associated computers'
        end
      end
    end
  end
end
