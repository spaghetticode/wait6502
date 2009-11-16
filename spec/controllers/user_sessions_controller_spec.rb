require File.dirname(__FILE__) + '/../spec_helper'

module UserSessionsHelpers  
  def mock_session(options={})
    mock_model(UserSession,
      :save => options[:save],
      :priority_record= => nil,
      :persisting? => true,
      :record => nil
    )
  end
end

describe UserSessionsController do
  include UserSessionsHelpers
  
  describe 'BEING LOGGED IN as user' do
    before do
      activate_authlogic
      UserSession.create!(Factory(:user))
    end
    
    actions = {:new => :get, :create => :post}
    actions.each_pair do |action, method|
      it "should flash and redirect on #{method.to_s.upcase} #{action.to_s.upcase}" do
        send(method, action)
        flash[:notice].should =~ /You must be logged out/
        response.should be_redirect
      end
    end
    
    describe 'GET DESTROY' do
      before do
        get :destroy, :id => '1'
      end

      it 'should flash and redirect on destroy' do
        flash[:notice].should =~ /User successfully logged out/
        response.should be_redirect
      end
    end
  end
  
  describe 'NOT BEING LOGGED IN as user' do
    describe 'GET DESTROY' do
      before do
        get :destroy, :id => '1'
      end
      
      it 'should flash and redirect' do
        flash[:notice].should =~ /You must be logged in to access this page/
        response.should be_redirect
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
  
      it 'should assing a new user_session instance' do
        assigns[:user_session].should be_new_record
        assigns[:user_session].should be_a(UserSession)
      end
    end
  
    describe 'POST CREATE' do
      describe 'with valid credentials' do
        before do
          UserSession.should_receive(:new).
            at_least(1).times.and_return(mock_session(:save => true))
          post :create, :user_session => {}
        end
    
        it 'should flash' do
          flash[:notice].should =~ /successfully logged in/
        end
    
        it 'should redirect' do
          response.should be_redirect
        end
    
        it 'should assign a new user_session instance' do
          assigns[:user_session].should be_a(UserSession)
        end
      end
  
      describe 'with invalid credentials' do
        before do
          UserSession.should_receive(:new).
            at_least(1).times.and_return(mock_session(:save => false))
          post :create, :user_session => {}
        end
    
        it 'should not flash' do
          flash[:notice].should be_nil
        end
    
        it 'should render new template' do
          response.should render_template(:new)
        end
    
        it 'should assign a new user_session instance' do
          assigns[:user_session].should be_a(UserSession)
        end
      end
    end
  end
end