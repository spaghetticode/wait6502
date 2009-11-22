require 'spec_helper'

describe Admin::TaintedOriginalPricesController do

  def mock_price(options={})
    @price ||= mock_model(OriginalPrice, options).as_null_object
  end
  
  describe 'when not logged in' do
    should_flash_and_redirect_for(
      :index => :get,
      :approve => :put,
      :destroy => :delete
    )
  end
  
  describe 'when logged in' do
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
      
      it 'should assign @tainted_prices' do
        assigns[:tainted_prices].should_not be_nil
      end
    end

    describe 'GET EDIT' do
      before do
        OriginalPrice.should_receive(:find).and_return(mock_price)
        get :edit, :id => '1'
      end
      
      it 'should be success' do
        response.should be_success
      end
      
      it 'should render edit template' do
        response.should render_template(:edit)
      end
      
      it 'should assign @tainted_price' do
        assigns[:tainted_price].should_not be_nil
      end
    end
    
    describe 'PUT APPROVE' do
      before do
        OriginalPrice.should_receive(:find).and_return(mock_price(:tainted => true))
        put :approve, :id => '1'
      end
      
      it 'should redirect' do
        response.should redirect_to admin_tainted_original_prices_path
      end
      
      it 'should assign @tainted_price' do
        assigns[:tainted_price].should_not be_nil
      end
      
      it 'should flash[:notice]' do
        flash[:notice].should_not be_nil
      end
    end
    
    describe 'DELETE DESTROY' do
      describe 'when price is tainted' do
        before do
          OriginalPrice.should_receive(:find).and_return(mock_price(:tainted => true))
          mock_price.should_receive(:destroy)
          delete :destroy, :id => '1'
        end
      
        it 'should redirect' do
          response.should redirect_to(admin_tainted_original_prices_path)
        end
        
        it 'should assign @tainted_price' do
          assigns[:tainted_price].should_not be_nil
        end
        
        it 'should flash[:notice]' do
          flash[:notice].should_not be_nil
        end
      end
      
      describe 'when price is not tainted (should never happen)' do
        before do
          OriginalPrice.should_receive(:find).and_return(mock_price(:tainted => nil))
          mock_price.should_not_receive(:destroy)
          delete :destroy, :id => '1'
        end
        
        it 'should redirect' do
          response.should redirect_to(admin_tainted_original_prices_path)
        end
        
        it 'should flash[:error]' do
          flash[:error].should_not be_nil
        end
      end
    end
  end
end
