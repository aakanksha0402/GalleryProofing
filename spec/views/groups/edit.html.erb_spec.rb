require 'rails_helper'

RSpec.describe "groups/edit", type: :view do
  before(:each) do
    @group = assign(:group, Group.create!(
      :fix_group => nil,
      :name => "MyString",
      :is_deleted => false,
      :pricing => nil
    ))
  end

  it "renders the edit group form" do
    render

    assert_select "form[action=?][method=?]", group_path(@group), "post" do

      assert_select "input#group_fix_group_id[name=?]", "group[fix_group_id]"

      assert_select "input#group_name[name=?]", "group[name]"

      assert_select "input#group_is_deleted[name=?]", "group[is_deleted]"

      assert_select "input#group_pricing_id[name=?]", "group[pricing_id]"
    end
  end
end
