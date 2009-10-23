require 'spec_helper'

module ComputersControllerHelper
  def mock_computer(options={})
    @mock ||= mock_model(Computer, options)
  end
  
  def post_create
    post :create, :computer => {}
  end
  
  def put_update
    put :update, :id => '1', :computer => {}
  end
end

describe Admin::ComputersController do
  include ComputersControllerHelper
  
  describe 'WITHOUT BEING AUTHENTICATED' do
    should_flash_and_redirect_for(
      :new => :get,
      :index => :get,
      :edit  => :get,
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
      
      it 'should render index template' do
        response.should render_template(:index)
      end
      
      it 'should assing @computers' do
        assigns[:computers].should_not be_nil
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
      
      it 'should assign @computer' do
        assigns[:computer].should be_new_record
      end
    end
    
    describe 'GET EDIT' do
      before do
        Computer.should_receive(:find).and_return(mock_computer)
        get :edit, :id => '1'
      end
      
      it 'should be success' do
        response.should be_success
      end
      
      it 'should render edit template' do
        response.should render_template(:edit)
      end
      
      it 'should assign @computer' do
        assigns[:computer].should_not be_nil
      end
    end
    
    describe 'POST CREATE' do
      describe 'with valid attributes' do
        before do
          Computer.should_receive(:new).and_return(mock_computer(:save => true))
          post_create
        end
        
        it 'should redirect to edit page' do
          response.should redirect_to(edit_admin_computer_path(mock_computer))
        end
        
        it 'should flash' do
          flash[:notice].should_not be_nil
        end
        
        it 'should assign @computer' do
          assigns[:computer].should_not be_nil
        end
      end
      
      describe 'with invalid attributes' do
        before do
          Computer.should_receive(:new).and_return(mock_computer(:save => false))
          post_create
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
        
        it 'should assign @computer' do
          assigns[:computer].should_not be_nil
        end
      end
    end
    
    describe 'PUT UPDATE' do
      describe 'with valid attributes' do
        before do
          Computer.should_receive(:find).and_return(mock_computer(:update_attributes => true))
          put_update
        end
        
        it 'should redirect to edit page' do
          response.should redirect_to(edit_admin_computer_path(mock_computer))
        end
        
        it 'should flash' do
          flash[:notice].should_not be_nil
        end
        
        it 'should assign @computer' do
          assigns[:computer].should_not be_nil
        end
      end
      
      describe 'with invalid attributes' do
        before do
          Computer.should_receive(:find).and_return(mock_computer(:update_attributes => false))
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
        
        it 'should assign @computer' do
          assigns[:computer].should_not be_nil
        end
      end
    end
      
    describe 'DELETE DESTROY' do
      before do
        Computer.should_receive(:find).and_return(mock_computer(:destroy => nil))
        mock_computer.should_receive(:destroy)
        delete :destroy, :id => '1'
      end
      
      it 'should redirect to admin_computers_path' do
        response.should redirect_to(admin_computers_path)
      end
      
      it 'should flash' do
        flash[:notice].should_not be_nil
      end      
    end    
  end  
end
