require 'spec_helper'

describe Admin::OriginalPricesController do
  def post_create
    post :create, :hardware_id => '1', :original_price => {}
  end
  
  describe 'not being logged in' do
    should_flash_and_redirect_for(
      {:create => :post, :destroy => :delete},
      :hardware_id => '1'
    )
  end
  
  describe 'being logged in' do
    before do
      activate_authlogic
      UserSession.create!(Factory(:user))
    end
    
    describe 'POST CREATE' do
      before do
        @original_prices = []
        hardware = mock_model(Hardware, :original_prices => @original_prices)
        Hardware.should_receive(:find).and_return(hardware)
      end
      describe 'with valid attributes' do
        before do
          @original_prices.stub!(:build => mock_model(OriginalPrice, :save => true))
          post_create
        end
        
        it 'should redirect' do
          response.should be_redirect
        end
        
        it 'should assign @original_price' do
          assigns[:original_price].should_not be_nil
        end
        
        it 'should assign @purchaseable' do
          assigns[:purchaseable].should_not be_nil
        end
        
        it 'should flash[:notice]' do
          flash[:notice].should_not be_nil
        end
      end
    
      describe 'with invalid attributes' do
        before do
          errors = []
          errors.stub!(:full_messages => [])
          @original_prices.stub!(:build => mock_model(OriginalPrice, :save => false, :errors => errors))
          post_create
        end
        
        it 'should redirect' do
          response.should be_redirect
        end
        
        it 'should assign @original_price' do
          assigns[:original_price].should_not be_nil
        end
        
        it 'should assign @purchaseable' do
          assigns[:purchaseable].should_not be_nil
        end
        
        it 'should flash[:error]' do
          flash[:error].should_not be_nil
        end
      end
    end
  
    describe 'DELETE DESTROY' do
      before do
        original_price = mock_model(OriginalPrice)
        original_price.should_receive(:destroy)
        original_prices = [original_price]
        original_prices.should_receive(:find).with('1').and_return(original_price)
        mock_hardware = mock_model(Hardware, :original_prices => original_prices)
        Hardware.should_receive(:find).with('2').and_return(mock_hardware)
        delete :destroy, :id => '1', :hardware_id => '2'
      end
      
      it 'should redirect' do
        response.should be_redirect
      end
      
      it 'should flash[:notice]' do
        flash[:notice].should_not be_nil
      end
    end
  end
end
