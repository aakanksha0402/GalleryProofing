require 'rails_helper'

RSpec.describe "discounts/show", type: :view do
  before(:each) do
    @discount = assign(:discount, Discount.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
