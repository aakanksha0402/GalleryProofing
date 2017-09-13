require 'rails_helper'

RSpec.describe "default_trigger_types/show", type: :view do
  before(:each) do
    @default_trigger_type = assign(:default_trigger_type, DefaultTriggerType.create!(
      :name => "Name",
      :active => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/false/)
  end
end
