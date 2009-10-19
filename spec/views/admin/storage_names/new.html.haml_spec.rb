require 'spec_helper'

describe "/admin/storage_names/new.html.haml" do
  include Admin::StorageNamesHelper

  before(:each) do
    assigns[:storage_name] = stub_model(StorageName,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "renders new storage_name form" do
    render

    response.should have_tag("form[action=?][method=post]", admin_storage_names_path) do
      with_tag("input#storage_name_name[name=?]", "storage_name[name]")
    end
  end
end
