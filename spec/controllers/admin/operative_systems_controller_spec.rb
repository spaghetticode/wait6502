require 'spec_helper'

module OperativeSystemsControllerHelper
  def post_create
    post :create, :operative_system => {}
  end

  def mock_operative_system(options={})
    @mock ||= mock_model(OperativeSystem, options)
  end
  
  def put_update
    put :update, :id => '1', :operative_system => {}
  end
  
  def delete_destroy
    delete :destroy, :id => '1'
  end
end

describe Admin::OperativeSystemsController do
  include OperativeSystemsControllerHelper
  
  describe 'WITHOUT BEING AUTHENTICATED' do
    should_flash_and_redirect_for(
      :new => :get,
      :index => :get,
      :edit  => :get,
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

    describe 'PUT UPDATE' do
      describe 'with valid parameters' do
        before do
          OperativeSystem.should_receive(:find).and_return(mock_operative_system(:update_attributes => true))
          put_update
        end
      
        it 'should redirect to admin_operative_systems_path' do
          response.should redirect_to(admin_operative_systems_path)
        end
      
        it 'should flash' do
          flash[:notice].should_not be_nil
        end
      
        it 'should assign @operative_system' do
          assigns[:operative_system].should_not be_nil
        end
      end
      
      describe 'with invalid parameters' do
        before do
          OperativeSystem.should_receive(:find).and_return(mock_operative_system(:update_attributes => false))
          put_update
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
      end
    end
    
    describe 'DELETE DESTROY' do
      before do
        mock_operative_system.should_receive(:destroy)
        OperativeSystem.should_receive(:find).and_return(mock_operative_system)
        delete_destroy
      end
      
      it 'should redirect to admin_operative_systems_path' do
        response.should redirect_to(admin_operative_systems_path)
      end
      
      it 'should flash' do
        flash[:notice].should_not be_nil
      end
    end
  end
end
