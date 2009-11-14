require 'spec_helper'

describe Admin::ResultsetsController do
  describe 'when not logged in' do
    should_flash_and_redirect_for(
      :create => :post
    )
  end
  
  describe 'being logged in' do
    before do
      activate_authlogic
      UserSession.create!(Factory(:user))
    end
    
    describe 'POST CREATE' do
      describe 'with valid params' do
        before do
          resultset = (mock_model(Resultset))
          Resultset.should_receive(:new).and_return(resultset)
          resultset.should_receive(:set_results)
          post :create, :resultset => {:keywords => 'kword'}
        end
    
        it 'should assing @resultset' do
          assigns[:resultset].should_not be_nil
        end
      
        it 'should render show template' do
          response.should render_template(:show)
        end
        
        it 'should not flash' do
          flash[:error].should be_nil
        end
        
        it 'should assign @item_ids' do
          assigns[:item_ids].should_not be_nil
        end
      end
      
      describe 'with invalid params (missing keywords)' do
        before do
          post :create, :resultset => {}
        end
        
        it 'should redirec to auctions page' do
          response.should redirect_to(admin_auctions_path)
        end
        
        it 'should flash[:error]' do
          flash[:error].should_not be_nil
        end
        
        it 'should not assign @resultset' do
          assigns[:resultset].should be_nil
        end
        
        it 'should not assign @item_ids' do
          assigns[:item_ids].should be_nil
        end
      end
    end
  end
end
