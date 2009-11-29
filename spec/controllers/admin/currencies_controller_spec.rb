require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

module CurrenciesControllerHelper
  def mock_currency(opts={})
   @mock ||=  mock_model(Currency, opts)
  end
  
  def put_update
    put :update, :id => '1', :currency => {}
  end
end

describe Admin::CurrenciesController do
  include CurrenciesControllerHelper
  
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
      describe 'when currency has no associated ebay site, auction or price' do
        before do
          Currency.should_receive(:find).and_return(mock_currency(:unused? => true))
          mock_currency.should_receive(:destroy)
          delete :destroy, :id => '1'
        end
      
        it 'should flash[:notice]' do
          flash[:notice].should == 'Currency was successfully destroyed.'
        end
        
        it 'should assign @currency' do
          assigns[:currency].should_not be_nil
        end
        
        it 'should redirect to currencies page' do
          response.should redirect_to(admin_currencies_path)
        end
      end
      
      describe 'when currency is associated to any ebay site, auction or price' do
        before do
          Currency.should_receive(:find).and_return(mock_currency(:unused? => false))
          mock_currency.should_not_receive(:destroy)
          delete :destroy, :id => '1'
        end
        
        it 'should redirec to currencies page' do
          response.should redirect_to(admin_currencies_path)
        end
        
        it 'should flash[:error]' do
          flash[:error].should_not be_nil
        end
        
        it 'should assign @currency' do
          assigns[:currency].should_not be_nil
        end
      end
    end
  end  
end
