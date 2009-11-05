require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

module HardwareTypesControllerHelper
  def post_create
    post :create, :hardware_type => {}
  end
  
  def mock_hardware_type(options={})
    @mock ||= mock_model(HardwareType, options)
  end
end

describe Admin::HardwareTypesController do
  include HardwareTypesControllerHelper
  
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
        HardwareType.should_receive(:ordered).and_return([mock_model(HardwareType)])
        get :index
      end
    
      it 'should be success' do
        response.should be_success
      end
    
      it 'should render new template' do
        response.should render_template(:index)
      end
    
      it 'should assign @hardware_types' do
        assigns[:hardware_types].should_not be_nil
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
    
      it 'should assign @hardware_type' do
        assigns[:hardware_type].should_not be_nil
      end
    
      it 'should assign a new record to @hardware_type' do
        assigns[:hardware_type].should be_new_record
      end
    end
  
    describe 'POST CREATE' do
      describe 'with valid attributes' do
        before do
          HardwareType.should_receive(:new).and_return(mock_hardware_type(:save => true))
          post_create
        end
      
        it 'should flash' do
          flash[:notice].should == 'Hardware type was successfully created.'
        end
      
        it 'should redirect to admin_hardware_types_path' do
          response.should redirect_to(admin_hardware_types_path)
        end
      
        it 'should assign @hardware_type' do
          assigns[:hardware_type].should_not be_nil
        end
      end
    
      describe 'with invalid attributes' do
        before do
          HardwareType.should_receive(:new).and_return(mock_hardware_type(:save => false))
          post_create
        end
        it 'should render new template' do
          response.should render_template(:new)
        end
      
        it 'should assign @hardware_type' do
          assigns[:hardware_type].should_not be_nil
        end
      end
    end
  
    describe 'DELETE DESTROY' do
      describe 'when hardware type has no associated hardware' do
        before do
          HardwareType.should_receive(:find).and_return(mock_hardware_type(:hardware => []))
          mock_hardware_type.should_receive(:destroy)
          delete :destroy, :id => '1'
        end
    
        it 'should flash' do
          flash[:notice].should == 'Hardware type was successfully destroyed.'
        end
    
        it 'should redirect to admin_hardware_types_path' do
          response.should redirect_to(admin_hardware_types_path)
        end
      end
      
      describe 'when hardware type has at least one hardware associated' do
        before do
          HardwareType.should_receive(:find).and_return(mock_hardware_type(:hardware => [mock_model(Hardware)]))
          mock_hardware_type.should_not_receive(:destroy)
          delete :destroy, :id => '1'
        end
        
        it 'should flash[:error]' do
          flash[:error].should_not be_nil
        end
        
        it 'should redirect to admin_hardware_types_path' do
          response.should redirect_to(admin_hardware_types_path)
        end
      end
    end
  end
end