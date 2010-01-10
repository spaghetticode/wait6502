require 'spec_helper'

describe "/admin/co_cpu_types/new.html.haml" do

  before(:each) do
    assigns[:co_cpu_type] = stub_model(CoCpuType,
      :new_record? => true
    )
  end

  it "renders new co_cpu_type form" do
    render

    response.should have_tag("form[action=?][method=post]", admin_co_cpu_types_path) do
    end
  end
end
