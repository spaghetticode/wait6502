require 'spec_helper'

describe Admin::AuctionsController do
  def mock_auction(options={})
    @mock_auction ||= mock_model(Auction, options)
  end
  
  describe 'when not logged in' do
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
  
  describe 'being authenticated' do
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
      
      it 'should assign @auctions' do
        assigns[:auctions].should_not be_nil
      end
    end
    
    describe 'GET EDIT' do
      before do
        Auction.stub!(:find).and_return(mock_auction)
        get :edit, :id => '1'
      end
      
      it 'should be success' do
        response.should be_success
      end
      
      it 'should render edit template' do
        response.should render_template(:edit)
      end
      
      it 'should assign @auction' do
        assigns[:auction].should_not be_nil
      end
    end
    
    describe 'PUT UPDATE' do
      describe 'with valid parameters' do
        before do
          Auction.should_receive(:find).and_return(mock_auction(:update_attributes => true))
          put :update, :id => '1', :auction => {}
        end
        
        it 'should redirect to auctions page' do
          response.should redirect_to(admin_auctions_path)
        end
        
        it 'should assign @auction' do
          assigns[:auction].should_not be_nil
        end
        
        it 'should flash' do
          flash[:notice].should =~ /was successfully updated/
        end
      end
      
      describe 'with invalid parameters' do
        before do
          Auction.should_receive(:find).and_return(mock_auction(:update_attributes => false))
          put :update, :id => '1', :auction => {}
        end        
        
        it 'should be success' do
          response.should be_success
        end
        
        it 'should render edit template' do
          response.should render_template(:edit)
        end
        
        it 'should assign @auction' do
          assigns[:auction].should_not be_nil
        end
        
        it 'should not flash' do
          flash[:notice].should be_nil
        end
      end
    end
    
    describe 'DELETE DESTROY' do
      before do
        mock_auction.should_receive(:destroy)
        Auction.should_receive(:find).and_return(mock_auction)
        delete :destroy, :id => '1'
      end
      
      it 'should redirect to auctions page' do
        response.should redirect_to(admin_auctions_path)
      end
      
      it 'should flash' do
        flash[:notice].should =~ /successfully destroyed/
      end
    end
    
    describe 'SET_FINAL_PRICE' do
      describe 'when auction went without bids' do
        before do
          Auction.should_receive(:find).and_return(mock_auction)
          mock_auction.should_receive(:set_final_price).and_return(false)
          put :set_final_price, :id => '1'          
        end
        
        it 'should assign @auction' do
          assigns[:auction].should_not be_nil
        end
        
        it 'should flash[:error]' do
          flash[:error].should_not be_nil
        end
        
        it 'should redirect to auctions page' do
          response.should redirect_to(admin_auctions_path)
        end
      end
      
      describe 'when auction went with a valid final price' do
        before do
          Auction.should_receive(:find).and_return(mock_auction)
          mock_auction.should_receive(:set_final_price).and_return(true)
          put :set_final_price, :id => '1'          
        end
        
        it 'should assign @auction' do
          assigns[:auction].should_not be_nil
        end
        
        it 'should flash[:notice]' do
          flash[:notice].should_not be_nil
        end
        
        it 'should redirect to auctions page' do
          response.should redirect_to(admin_auctions_path)
        end
      end
    end
  end
end
