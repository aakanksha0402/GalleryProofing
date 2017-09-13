require 'rails_helper'

RSpec.describe "pricings/new", type: :view do
  before(:each) do
    assign(:pricing, Pricing.new(
      :name => "MyString",
      :is_deleted => false,
      :user => nil,
      :pricing_style => nil
    ))
  end

  it "renders new pricing form" do
    render

    assert_select "form[action=?][method=?]", pricings_path, "post" do

      assert_select "input#pricing_name[name=?]", "pricing[name]"

      assert_select "input#pricing_is_deleted[name=?]", "pricing[is_deleted]"

      assert_select "input#pricing_user_id[name=?]", "pricing[user_id]"

      assert_select "input#pricing_pricing_style_id[name=?]", "pricing[pricing_style_id]"
    end
  end
end
