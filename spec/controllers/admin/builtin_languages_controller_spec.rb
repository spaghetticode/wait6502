require 'spec_helper'

module BuiltinLanguagesControllerHelper
  def post_create
    post :create, :builtin_language => {}
  end

  def mock_builtin_language(options={})
    mock_model(BuiltinLanguage, options)
  end
end

describe Admin::BuiltinLanguagesController do
  include BuiltinLanguagesControllerHelper
  
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

    describe 'DELETE DELETE' do
    # il classico metodo destroy è stato sostituito da questo delete che opera
    # attraverso un form che posta gli id. Tutto sto casino è per non avere negli url
    # l'id con il punto, visto che rails lo interpreta come separatore per format
    
      before do
        BuiltinLanguage.should_receive(:find).with('BASIC').and_return(mock_builtin_language(:destroy => nil))
        delete :delete, :id => 'BASIC'
      end

      it 'should flash' do
        flash[:notice].should == 'Builtin language was successfully destroyed.'
      end

      it 'should redirect to admin_builtin_languages_path' do
        response.should redirect_to(admin_builtin_languages_path)
      end
    end
  end
end
