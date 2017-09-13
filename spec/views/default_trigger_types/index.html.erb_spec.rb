require 'rails_helper'

RSpec.describe "default_trigger_types/index", type: :view do
  before(:each) do
    assign(:default_trigger_types, [
      DefaultTriggerType.create!(
        :name => "Name",
        :active => false
      ),
      DefaultTriggerType.create!(
        :name => "Name",
        :active => false
      )
    ])
  end

  it "renders a list of default_trigger_types" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
