require 'rails_helper'

RSpec.describe "data_plans/new", type: :view do
  before(:each) do
    assign(:data_plan, DataPlan.new(
      :photos_number => "MyString",
      :mobile_apps_number => "MyString",
      :invoices_number => "MyString",
      :data_period => "MyString",
      :plan_price => "MyString"
    ))
  end

  it "renders new data_plan form" do
    render

    assert_select "form[action=?][method=?]", data_plans_path, "post" do

      assert_select "input#data_plan_photos_number[name=?]", "data_plan[photos_number]"

      assert_select "input#data_plan_mobile_apps_number[name=?]", "data_plan[mobile_apps_number]"

      assert_select "input#data_plan_invoices_number[name=?]", "data_plan[invoices_number]"

      assert_select "input#data_plan_data_period[name=?]", "data_plan[data_period]"

      assert_select "input#data_plan_plan_price[name=?]", "data_plan[plan_price]"
    end
  end
end
