require 'spec_helper'

module OperativeSystemsControllerHelper
  def post_create
    post :create, :operative_system => {}
  end

  def mock_operative_system(options={})
    mock_model(OperativeSystem, options)
  end
end

describe Admin::OperativeSystemsController do
  include OperativeSystemsControllerHelper
  
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

      it 'should assign @operative_systems' do
        assigns[:operative_systems].should_not be_nil
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

      it 'should assign @operative_system' do
        assigns[:operative_system].should_not be_nil
      end

      it 'should assign a new record to @operative_system' do
        assigns[:operative_system].should be_new_record
      end
    end

    describe 'POST CREATE' do
      describe 'with valid attributes' do
        before do
          OperativeSystem.should_receive(:new).and_return(mock_operative_system(:save => true))
          post_create
        end

        it 'should flash' do
          flash[:notice].should == 'Operative system was successfully created.'
        end

        it 'should redirect to admin_operative_systems_path' do
          response.should redirect_to(admin_operative_systems_path)
        end

        it 'should assign @operative_system' do
          assigns[:operative_system].should_not be_nil
        end
      end

      describe 'with invalid attributes' do
        before do
          OperativeSystem.should_receive(:new).and_return(mock_operative_system(:save => false))
          post_create
        end
        it 'should render new template' do
          response.should render_template(:new)
        end

        it 'should assign @operative_system' do
          assigns[:operative_system].should_not be_nil
        end
      end
    end

    describe 'DELETE DELETE' do
    # il classico metodo destroy è stato sostituito da questo delete che opera
    # attraverso un form che posta gli id. Tutto sto casino è per non avere negli url
    # l'id con il punto, visto che rails lo interpreta come separatore per format
    
      before do
        OperativeSystem.should_receive(:find).with('3.5 inches').and_return(mock_operative_system(:destroy => nil))
        delete :delete, :id => '3.5 inches'
      end

      it 'should flash' do
        flash[:notice].should == 'Operative system was successfully destroyed.'
      end

      it 'should redirect to admin_operative_systems_path' do
        response.should redirect_to(admin_operative_systems_path)
      end
    end
  end
end
