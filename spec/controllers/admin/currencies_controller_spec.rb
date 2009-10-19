require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

module CurrenciesControllerHelper
  def mock_currency(opts={})
    mock_model(Currency, opts)
  end
end

describe Admin::CurrenciesController do
  include CurrenciesControllerHelper
  
  describe 'WITHOUT BEING AUTHENTICATED' do
    should_flash_and_redirect_for(
      :new => :get,
      :show => :get,
      :edit => :get,
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
        assigns[:currencies].should_not be_nil
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
      
      it 'should assign @currency' do
        assigns[:currency].should_not be_nil
      end
      
      it '@currency should be new record' do
        assigns[:currency].should be_new_record
      end
    end
    
    describe 'GET EDIT' do
      before do
        Currency.should_receive(:find).and_return(mock_currency)
        get :edit, :id => '1'
      end
      
      it 'should be success' do
        response.should be_success
      end
      
      it 'should render edit template' do
        response.should render_template(:edit)
      end
      
      it 'should assign @currency' do
        assigns[:currency].should_not be_nil
      end
    end
    
    describe 'POST CREATE' do
      describe 'with valid parameters' do        
        before do
          Currency.should_receive(:new).and_return(mock_currency(:save => true))
          post :create, :currency => {}
        end
      
        it 'should flash' do
          flash[:notice].should == 'Currency was successfully created.'
        end
      
        it 'should redirect to admin_currencies_path' do
          response.should redirect_to(admin_currencies_path)
        end
      
        it 'should assign @currency' do
          assigns[:currency].should_not be_nil
        end
      end
      
      describe 'with invalid parameters' do
        before do
          Currency.should_receive(:new).and_return(mock_currency(:save => false))
          post :create, :currency => {}
        end
        
        it 'should not flash' do
          flash[:notice].should be_nil
        end
        
        it 'should render new template' do
          response.should render_template(:new)
        end
        
        it 'should assign @currency' do
          assigns[:currency].should_not be_nil
        end
      end
    end
    
    describe 'DELETE DESTROY' do
      before do
        Currency.should_receive(:find).and_return(mock_currency(:destroy => nil))
        delete :destroy, :id => '1'
      end
      
      it 'should flash' do
        flash[:notice].should == 'Currency was successfully destroyed.'
      end
      
      it 'should redirect to admin_currencies_path' do
        response.should redirect_to(admin_currencies_path)
      end
    end
  end  
end
