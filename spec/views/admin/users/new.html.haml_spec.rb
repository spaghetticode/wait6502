require 'spec_helper'

describe "/admin/users/new.html.haml" do

  before(:each) do
    assigns[:user] = stub_model(User,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "renders new user form" do
    render

    response.should have_tag("form[action=?][method=post]", admin_users_path) do
      with_tag("input#user_email[name=?]", "user[email]")
    end
  end
end