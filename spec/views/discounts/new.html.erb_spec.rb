require 'rails_helper'

RSpec.describe "discounts/new", type: :view do
  before(:each) do
    assign(:discount, Discount.new())
  end

  it "renders new discount form" do
    render

    assert_select "form[action=?][method=?]", discounts_path, "post" do
    end
  end
end
