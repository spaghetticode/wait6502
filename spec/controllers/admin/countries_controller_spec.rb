require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

module CountriesControllerHelper
  def post_create
    post :create, :country => {}
  end
  
  def mock_country(options={})
    @mock ||= mock_model(Country, options)
  end
end

describe Admin::CountriesController do
  include CountriesControllerHelper
  
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
    
      it 'should assign @countries' do
        assigns[:countries].should_not be_nil
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
    
      it 'should assign @country' do
        assigns[:country].should_not be_nil
      end
    
      it 'should assign a new record to @country' do
        assigns[:country].should be_new_record
      end
    end
  
    describe 'POST CREATE' do
      describe 'with valid attributes' do
        before do
          Country.should_receive(:new).and_return(mock_country(:save => true))
          post_create
        end
      
        it 'should flash' do
          flash[:notice].should == 'Country was successfully created.'
        end
      
        it 'should redirect to admin_countries_path' do
          response.should redirect_to(admin_countries_path)
        end
      
        it 'should assign @country' do
          assigns[:country].should_not be_nil
        end
      end
    
      describe 'with invalid attributes' do
        before do
          Country.should_receive(:new).and_return(mock_country(:save => false))
          post_create
        end
        it 'should render new template' do
          response.should render_template(:new)
        end
      
        it 'should assign @country' do
          assigns[:country].should_not be_nil
        end
      end
    end
  
    describe 'DELETE DESTROY' do
      describe 'when country has empty associations' do
        before do
          Country.should_receive(:find).and_return(mock_country)
          mock_country.stub!(:unused? => true)
          mock_country.should_receive(:destroy)
          delete :destroy, :id => '1'
        end
    
        it 'should flash' do
          flash[:notice].should == 'Country was successfully destroyed.'
        end
    
        it 'should redirect to admin_countries_path' do
          response.should redirect_to(admin_countries_path)
        end
      end
      
      describe 'when country associations are not empty' do
        before do
          manufacturer = mock_model(Manufacturer)
          Country.should_receive(:find).and_return(mock_country(:manufacturers => [manufacturer], :unused? => false))
          Country.should_not_receive(:destroy)
          delete :destroy, :id => '1'
        end
        
        it 'should flash[:error]' do
          flash[:error].should_not be_nil
        end
    
        it 'should redirect to admin_countries_path' do
          response.should redirect_to(admin_countries_path)
        end
      end
    end
  end
end