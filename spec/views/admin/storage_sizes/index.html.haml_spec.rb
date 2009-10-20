require 'spec_helper'

describe "/admin/storage_sizes/index.html.haml" do
  include Admin::StorageSizesHelper

  before(:each) do
    assigns[:storage_sizes] = [
      stub_model(StorageSize,
        :name => "value for name"
      ),
      stub_model(StorageSize,
        :name => "value for name"
      )
    ]
  end

  it "renders a list of admin_storage_sizes" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
