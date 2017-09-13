require 'rails_helper'

RSpec.describe "data_plans/index", type: :view do
  before(:each) do
    assign(:data_plans, [
      DataPlan.create!(
        :photos_number => "Photos Number",
        :mobile_apps_number => "Mobile Apps Number",
        :invoices_number => "Invoices Number",
        :data_period => "Data Period",
        :plan_price => "Plan Price"
      ),
      DataPlan.create!(
        :photos_number => "Photos Number",
        :mobile_apps_number => "Mobile Apps Number",
        :invoices_number => "Invoices Number",
        :data_period => "Data Period",
        :plan_price => "Plan Price"
      )
    ])
  end

  it "renders a list of data_plans" do
    render
    assert_select "tr>td", :text => "Photos Number".to_s, :count => 2
    assert_select "tr>td", :text => "Mobile Apps Number".to_s, :count => 2
    assert_select "tr>td", :text => "Invoices Number".to_s, :count => 2
    assert_select "tr>td", :text => "Data Period".to_s, :count => 2
    assert_select "tr>td", :text => "Plan Price".to_s, :count => 2
  end
end
