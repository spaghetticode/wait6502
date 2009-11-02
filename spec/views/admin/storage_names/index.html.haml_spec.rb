require 'spec_helper'

describe "/admin/storage_names/index.html.haml" do

  before(:each) do
    assigns[:storage_names] = [
      stub_model(StorageName,
        :name => "value for name"
      ),
      stub_model(StorageName,
        :name => "value for name"
      )
    ]
  end

  it "renders a list of admin_storage_names" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
