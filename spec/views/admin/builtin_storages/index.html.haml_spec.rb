require 'spec_helper'

describe "/admin/builtin_storages/index.html.haml" do
  include Admin::BuiltinStoragesHelper

  before(:each) do
    assigns[:builtin_storages] = [
      stub_model(BuiltinStorage,
        :storage_name_id => "value for storage_name_id",
        :storage_format_id => "value for storage_format_id",
        :storage_size_id => "value for storage_size_id"
      ),
      stub_model(BuiltinStorage,
        :storage_name_id => "value for storage_name_id",
        :storage_format_id => "value for storage_format_id",
        :storage_size_id => "value for storage_size_id"
      )
    ]
    assigns[:builtin_storages].stub!(:total_pages).and_return(0)
  end

  it "renders a list of admin_builtin_storages" do
    render
    response.should have_tag("tr>td", "value for storage_name_id".to_s, 2)
    response.should have_tag("tr>td", "value for storage_format_id".to_s, 2)
    response.should have_tag("tr>td", "value for storage_size_id".to_s, 2)
  end
end
