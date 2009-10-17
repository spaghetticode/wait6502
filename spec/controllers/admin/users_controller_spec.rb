require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

module UsersControllerHelpers  
  def post_create
    post :create, :user => {}
  end
end

describe Admin::UsersController do
  include UsersControllerHelpers
  
  describe 'NOT BEING LOGGED IN as user' do
    actions = {:new => :get, :create => :post}
    actions.each_pair do |action, method|
      it "should flash and redirect to user login path on #{method.to_s.upcase} #{action.to_s.upcase}" do
        send(method, action, :id => '1')
        flash[:notice].should =~ /You must be logged in/
        response.should redirect_to(new_user_session_path)
      end
    end
  end
  
  describe 'BEING LOGGED IN as user' do
    before do
      activate_authlogic
      UserSession.create!(Factory.build(:user))
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
    
      it 'should assign a new user instance to @user' do
        assigns[:user].should be_new_record
        assigns[:user].should be_a(User)
      end
    end
  
    describe 'POST CREATE' do    
      describe 'with valid attributes' do
        before do
          mock_user = mock_model(User, :save => true)
          User.should_receive(:new).and_return(mock_user)
          post_create
        end
      
        it 'should flash' do
          flash[:notice].should =~ /user successfully created/i
        end
      
        it 'should redirect' do
          response.should be_redirect
        end
      
        it 'should assign a new user' do
          assigns[:user].should be_a(User)
        end
      
        it 'should save the new user instance' do
          assigns[:user].should_not be_new_record
        end
      end
    
      describe 'with invalid attributes' do
        before do
          mock_user = mock_model(User, :save => false, :new_record? => true)
          User.should_receive(:new).and_return(mock_user)
          post_create
        end
      
        it 'should not flash' do
          flash[:notice].should be_nil
        end
      
        it 'should render new template' do
          response.should render_template(:new)
        end
      
        it 'should assign a new user' do
          assigns[:user].should be_a(User)
        end
      
        it 'should not save the new user instance' do
          assigns[:user].should be_new_record
        end
      end
    end
  end
end
