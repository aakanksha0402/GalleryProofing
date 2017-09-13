require 'rails_helper'

RSpec.describe "data_plans/show", type: :view do
  before(:each) do
    @data_plan = assign(:data_plan, DataPlan.create!(
      :photos_number => "Photos Number",
      :mobile_apps_number => "Mobile Apps Number",
      :invoices_number => "Invoices Number",
      :data_period => "Data Period",
      :plan_price => "Plan Price"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Photos Number/)
    expect(rendered).to match(/Mobile Apps Number/)
    expect(rendered).to match(/Invoices Number/)
    expect(rendered).to match(/Data Period/)
    expect(rendered).to match(/Plan Price/)
  end
end
