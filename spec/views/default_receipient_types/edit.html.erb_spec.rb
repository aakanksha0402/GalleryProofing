require 'rails_helper'

RSpec.describe "default_receipient_types/edit", type: :view do
  before(:each) do
    @default_receipient_type = assign(:default_receipient_type, DefaultReceipientType.create!(
      :name => "MyString",
      :active => false
    ))
  end

  it "renders the edit default_receipient_type form" do
    render

    assert_select "form[action=?][method=?]", default_receipient_type_path(@default_receipient_type), "post" do

      assert_select "input#default_receipient_type_name[name=?]", "default_receipient_type[name]"

      assert_select "input#default_receipient_type_active[name=?]", "default_receipient_type[active]"
    end
  end
end
