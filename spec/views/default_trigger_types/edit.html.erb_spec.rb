require 'rails_helper'

RSpec.describe "default_trigger_types/edit", type: :view do
  before(:each) do
    @default_trigger_type = assign(:default_trigger_type, DefaultTriggerType.create!(
      :name => "MyString",
      :active => false
    ))
  end

  it "renders the edit default_trigger_type form" do
    render

    assert_select "form[action=?][method=?]", default_trigger_type_path(@default_trigger_type), "post" do

      assert_select "input#default_trigger_type_name[name=?]", "default_trigger_type[name]"

      assert_select "input#default_trigger_type_active[name=?]", "default_trigger_type[active]"
    end
  end
end
