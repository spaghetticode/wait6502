require 'spec_helper'

describe "/admin/builtin_storages/new.html.haml" do
  include Admin::BuiltinStoragesHelper

  before(:each) do
    assigns[:builtin_storage] = stub_model(BuiltinStorage,
      :new_record? => true,
      :storage_name_id => "value for storage_name_id",
      :storage_format_id => "value for storage_format_id",
      :storage_size_id => "value for storage_size_id"
    )
  end

  it "renders new builtin_storage form" do
    render

    response.should have_tag("form[action=?][method=post]", admin_builtin_storages_path) do
      with_tag("select#builtin_storage_storage_name_id[name=?]", "builtin_storage[storage_name_id]")
      with_tag("select#builtin_storage_storage_format_id[name=?]", "builtin_storage[storage_format_id]")
      with_tag("select#builtin_storage_storage_size_id[name=?]", "builtin_storage[storage_size_id]")
    end
  end
end
