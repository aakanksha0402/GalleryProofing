require 'rails_helper'

RSpec.describe "automation_series/index", type: :view do
  before(:each) do
    assign(:automation_series, [
      AutomationSeries.create!(
        :name => "Name"
      ),
      AutomationSeries.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of automation_series" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
