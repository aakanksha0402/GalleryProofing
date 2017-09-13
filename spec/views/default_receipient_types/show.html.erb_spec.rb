require 'rails_helper'

RSpec.describe "default_receipient_types/show", type: :view do
  before(:each) do
    @default_receipient_type = assign(:default_receipient_type, DefaultReceipientType.create!(
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
