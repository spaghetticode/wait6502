require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

module ComputerTypesControllerHelper
  def post_create
    post :create, :computer_type => {}
  end
  
  def mock_computer_type(options={})
    @mock ||= mock_model(ComputerType, options)
  end
end

describe Admin::ComputerTypesController do
  include ComputerTypesControllerHelper
  
  describe 'WITHOUT BEING AUTHENTICATED' do
    should_flash_and_redirect_for(
      :new => :get,
      :index => :get,
      :create => :post,
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
    
      it 'should assign @computer_types' do
        assigns[:computer_types].should_not be_nil
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
    
      it 'should assign @computer_type' do
        assigns[:computer_type].should_not be_nil
      end
    
      it 'should assign a new record to @computer_type' do
        assigns[:computer_type].should be_new_record
      end
    end
  
    describe 'POST CREATE' do
      describe 'with valid attributes' do
        before do
          ComputerType.should_receive(:new).and_return(mock_computer_type(:save => true))
          post_create
        end
      
        it 'should flash' do
          flash[:notice].should == 'Computer type was successfully created.'
        end
      
        it 'should redirect to admin_computer_types_path' do
          response.should redirect_to(admin_computer_types_path)
        end
      
        it 'should assign @computer_type' do
          assigns[:computer_type].should_not be_nil
        end
      end
    
      describe 'with invalid attributes' do
        before do
          ComputerType.should_receive(:new).and_return(mock_computer_type(:save => false))
          post_create
        end
        it 'should render new template' do
          response.should render_template(:new)
        end
      
        it 'should assign @computer_type' do
          assigns[:computer_type].should_not be_nil
        end
      end
    end
  
    describe 'DELETE DESTROY' do
      describe 'when computer type has no associated computer' do
        before do
          ComputerType.should_receive(:find).and_return(mock_computer_type(:computers => []))
          mock_computer_type.should_receive(:destroy)
          delete :destroy, :id => '1'
        end
    
        it 'should flash' do
          flash[:notice].should == 'Computer type was successfully destroyed.'
        end
    
        it 'should redirect to admin_computer_types_path' do
          response.should redirect_to(admin_computer_types_path)
        end
      end
      
      describe 'when computer type has at least one computer associated' do
        before do
          ComputerType.should_receive(:find).and_return(mock_computer_type(:computers => [mock_model(Computer)]))
          mock_computer_type.should_not_receive(:destroy)
          delete :destroy, :id => '1'
        end
        
        it 'should flash[:error]' do
          flash[:error].should_not be_nil
        end
        
        it 'should redirect to admin_computer_types_path' do
          response.should redirect_to(admin_computer_types_path)
        end
      end
    end
  end
end