require 'rails_helper'

RSpec.describe "discounts/edit", type: :view do
  before(:each) do
    @discount = assign(:discount, Discount.create!())
  end

  it "renders the edit discount form" do
    render

    assert_select "form[action=?][method=?]", discount_path(@discount), "post" do
    end
  end
end
