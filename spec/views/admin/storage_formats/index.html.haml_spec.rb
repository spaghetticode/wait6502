require 'spec_helper'

describe "/admin/storage_formats/index.html.haml" do

  before(:each) do
    assigns[:storage_formats] = [
      stub_model(StorageFormat,
        :name => "value for name"
      ),
      stub_model(StorageFormat,
        :name => "value for name"
      )
    ]
  end

  it "renders a list of admin_storage_formats" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
