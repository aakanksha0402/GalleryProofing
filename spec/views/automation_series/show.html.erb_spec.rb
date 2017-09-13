require 'rails_helper'

RSpec.describe "automation_series/show", type: :view do
  before(:each) do
    @automation_series = assign(:automation_series, AutomationSeries.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
