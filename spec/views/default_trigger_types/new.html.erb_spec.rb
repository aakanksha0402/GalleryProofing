require 'rails_helper'

RSpec.describe "default_trigger_types/new", type: :view do
  before(:each) do
    assign(:default_trigger_type, DefaultTriggerType.new(
      :name => "MyString",
      :active => false
    ))
  end

  it "renders new default_trigger_type form" do
    render

    assert_select "form[action=?][method=?]", default_trigger_types_path, "post" do

      assert_select "input#default_trigger_type_name[name=?]", "default_trigger_type[name]"

      assert_select "input#default_trigger_type_active[name=?]", "default_trigger_type[active]"
    end
  end
end
