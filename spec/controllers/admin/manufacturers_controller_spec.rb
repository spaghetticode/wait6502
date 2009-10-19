require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

module ManufacturersControllerHelper
  def mock_manufacturer(options={})
    mock_model(Manufacturer, options)
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
          post :create, :manufacturer => {}
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
          post :create, :manufacturer => {}
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
    
    describe 'DELETE DESTROY' do
      before do
        Manufacturer.should_receive(:find).and_return(mock_manufacturer(:destroy => nil))
        delete :destroy, :id => '1'
      end
      
      it 'should flash' do
        flash[:notice].should == 'Manufacturer was successfully destroyed.'
      end
      
      it 'should redirect to admin_manufacturers_path' do
        response.should redirect_to(admin_manufacturers_path)
      end
    end
  end
end
