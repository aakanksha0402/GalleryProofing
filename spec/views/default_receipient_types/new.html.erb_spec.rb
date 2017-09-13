require 'rails_helper'

RSpec.describe "default_receipient_types/new", type: :view do
  before(:each) do
    assign(:default_receipient_type, DefaultReceipientType.new(
      :name => "MyString",
      :active => false
    ))
  end

  it "renders new default_receipient_type form" do
    render

    assert_select "form[action=?][method=?]", default_receipient_types_path, "post" do

      assert_select "input#default_receipient_type_name[name=?]", "default_receipient_type[name]"

      assert_select "input#default_receipient_type_active[name=?]", "default_receipient_type[active]"
    end
  end
end
