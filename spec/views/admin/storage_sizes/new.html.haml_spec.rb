require 'spec_helper'

describe "/admin/storage_sizes/new.html.haml" do
  include Admin::StorageSizesHelper

  before(:each) do
    assigns[:storage_size] = stub_model(StorageSize,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "renders new storage_size form" do
    render

    response.should have_tag("form[action=?][method=post]", admin_storage_sizes_path) do
      with_tag("input#storage_size_name[name=?]", "storage_size[name]")
    end
  end
end
