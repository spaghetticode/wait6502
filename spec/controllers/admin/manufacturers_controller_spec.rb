require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

module ManufacturersControllerHelper
  def mock_manufacturer(options={})
    @mock ||= mock_model(Manufacturer, options)
  end
  
  def post_create
    post :create, :manufacturer => {}
  end
  
  def put_update
    put :update, :id => '1', :manufacturer => {}
  end
end

describe Admin::ManufacturersController do
  include ManufacturersControllerHelper
  
  describe 'WITHOUT BEING AUTHENTICATED' do
    should_flash_and_redirect_for(
      :new => :get,
      :show => :get,
      :index => :get,
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
      
      it 'should assign @currencies' do
        assigns[:manufacturers].should_not be_nil
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
      
      it 'should assign @manufacturer' do
        assigns[:manufacturer].should_not be_nil
      end
      
      it '@manufacturer should be new record' do
        assigns[:manufacturer].should be_new_record
      end
    end
    
    describe 'GET EDIT' do
      before do
        Manufacturer.should_receive(:find).and_return(mock_manufacturer)
        get :edit, :id => '1'
      end
      
      it 'should be success' do
        response.should be_success
      end
      
      it 'should render edit template' do
        response.should render_template(:edit)
      end
      
      it 'should assign @manufacturer' do
        assigns[:manufacturer].should_not be_nil
      end
    end
    
    describe 'POST CREATE' do
      describe 'with valid parameters' do        
        before do
          Manufacturer.should_receive(:new).and_return(mock_manufacturer(:save => true))
          post_create
        end
      
        it 'should flash' do
          flash[:notice].should == 'Manufacturer was successfully created.'
        end
      
        it 'should redirect to currencies_path' do
          response.should redirect_to(admin_manufacturers_path)
        end
      
        it 'should assign @Manufacturer' do
          assigns[:manufacturer].should_not be_nil
        end
      end
      
      describe 'with invalid parameters' do
        before do
          Manufacturer.should_receive(:new).and_return(mock_manufacturer(:save => false))
          post_create
        end
        
        it 'should not flash' do
          flash[:notice].should be_nil
        end
        
        it 'should render new template' do
          response.should render_template(:new)
        end
        
        it 'should assign @Manufacturer' do
          assigns[:manufacturer].should_not be_nil
        end
      end
    end
    
    describe 'PUT UPDATE' do
      describe 'with valid parameters' do
        before do
          Manufacturer.should_receive(:find).and_return(mock_manufacturer(:update_attributes => true))
          put_update
        end
        
        it 'should redirect to manufacturers page' do
          response.should redirect_to admin_manufacturers_path
        end
        
        it 'should flash' do
          flash[:notice].should_not be_nil
        end
        
        it 'should assign @manufacturer' do
          assigns[:manufacturer].should_not be_nil
        end 
      end
      
      describe 'with invalid parameters' do
        before do
          Manufacturer.should_receive(:find).and_return(mock_manufacturer(:update_attributes => false))
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
      describe 'when manufacturer has no associated hardware' do
        before do
          mock_manufacturer(:hardware => [], :cpus => [], :co_cpus => [])
          Manufacturer.should_receive(:find).and_return(mock_manufacturer)
          mock_manufacturer.should_receive(:destroy)
          delete :destroy, :id => '1'
        end
      
        it 'should flash' do
          flash[:notice].should == 'Manufacturer was successfully destroyed.'
        end
      
        it 'should redirect to admin_manufacturers_path' do
          response.should redirect_to(admin_manufacturers_path)
        end
      end
      
      describe 'when manufacturer has at least one associated hardware' do
        before do
          mock_manufacturer(:hardware => [mock_model(Hardware)], :cpus => [], :co_cpus => [])
          Manufacturer.should_receive(:find).and_return(mock_manufacturer)
          mock_manufacturer.should_not_receive(:destroy)
          delete :destroy, :id => '1'
        end
        
        it 'should flash[:error]' do
          flash[:error].should_not be_nil
        end
        
        it 'should redirect to admin_manufacturers_path' do
          response.should redirect_to(admin_manufacturers_path)
        end
      end
      
      describe 'when manufacturer has at least one associated CPU' do
        before do
          mock_manufacturer(:hardware => [], :cpus => [mock_model(Cpu)], :co_cpus => [])
          Manufacturer.should_receive(:find).and_return(mock_manufacturer)
          mock_manufacturer.should_not_receive(:destroy)
          delete :destroy, :id => '1'
        end
        
        it 'should flash[:error]' do
          flash[:error].should_not be_nil
        end
        
        it 'should redirect to admin_manufacturers_path' do
          response.should redirect_to(admin_manufacturers_path)
        end
      end
      
      describe 'when manufacturer has at least one associated co-CPU' do
        before do
          mock_manufacturer(:hardware => [], :co_cpus => [mock_model(CoCpu)], :cpus => [])
          Manufacturer.should_receive(:find).and_return(mock_manufacturer)
          mock_manufacturer.should_not_receive(:destroy)
          delete :destroy, :id => '1'
        end
        
        it 'should flash[:error]' do
          flash[:error].should_not be_nil
        end
        
        it 'should redirect to admin_manufacturers_path' do
          response.should redirect_to(admin_manufacturers_path)
        end
      end
    end
  end
end
