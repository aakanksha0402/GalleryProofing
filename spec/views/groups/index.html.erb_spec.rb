require 'rails_helper'

RSpec.describe "groups/index", type: :view do
  before(:each) do
    assign(:groups, [
      Group.create!(
        :fix_group => nil,
        :name => "Name",
        :is_deleted => false,
        :pricing => nil
      ),
      Group.create!(
        :fix_group => nil,
        :name => "Name",
        :is_deleted => false,
        :pricing => nil
      )
    ])
  end

  it "renders a list of groups" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
