require 'rails_helper'

RSpec.describe "discounts/index", type: :view do
  before(:each) do
    assign(:discounts, [
      Discount.create!(),
      Discount.create!()
    ])
  end

  it "renders a list of discounts" do
    render
  end
end
