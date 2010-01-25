require 'spec_helper'

describe "/admin/users/index" do
  before(:each) do
    assigns[:users] = [mock_model(User, :email => 'andrea@test.com')]
    render 'admin/users/index'
  end

  it "should have expected text" do
    response.should have_tag('h2', 'Users')
    response.should have_tag('table') do
      with_tag 'td', 'andrea@test.com'
    end
  end
end