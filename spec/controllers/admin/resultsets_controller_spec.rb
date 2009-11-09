require 'spec_helper'

describe Admin::ResultsetsController do
  describe 'being logged in' do
    before do
      activate_authlogic
      UserSession.create!(Factory(:user))
    end
    
    describe 'POST CREATE' do
      before do
        Resultset.should_receive(:new).and_return(mock_model(Resultset))
        post :create, :resultset => {:keywords => 'kword'}
      end
    
      it 'should assing @resultset' do
        assigns[:resultset].should_not be_nil
      end
    end
  end
end
