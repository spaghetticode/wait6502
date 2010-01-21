require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  describe 'with valid attributes for email, password and password_confirmation' do
    it 'should be valid' do
      Factory(:user).should be_valid
    end
  end
  
  describe 'a new user instance' do
    it 'should not be valid' do
      User.new.should_not be_valid
    end
    
    it 'should require email' do
      User.new.should have_at_least(1).error_on(:email)
    end
    
    it 'should require password' do
      User.new.should have_at_least(1).error_on(:password)
    end
    
    it 'should require password_confirmation' do
      User.new.should have_at_least(1).error_on(:password_confirmation)
    end
    
    it 'should require password to match password confirmation' do
      password = 'secret'
      user = User.new(:password => password, :password_confirmation => password.reverse)
      user.should have_at_least(1).error_on(:password)
    end
  end
  
  context 'ordered named scope' do
    before do
      (1..3).map { Factory(:user)}
    end
    
    it 'should sort users by email' do
      User.ordered.should == User.all.sort_by(&:email)
    end
  end
end
