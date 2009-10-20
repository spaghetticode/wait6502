require 'spec_helper'

describe "/admin/storage_formats/new.html.haml" do
  include Admin::StorageFormatsHelper

  before(:each) do
    assigns[:storage_format] = stub_model(StorageFormat,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "renders new storage_format form" do
    render

    response.should have_tag("form[action=?][method=post]", admin_storage_formats_path) do
      with_tag("input#storage_format_name[name=?]", "storage_format[name]")
    end
  end
end
