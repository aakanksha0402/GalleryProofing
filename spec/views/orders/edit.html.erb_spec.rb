require 'rails_helper'

RSpec.describe "orders/edit", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      :email_id => "MyString",
      :first_name => "MyString",
      :last_name => "MyString",
      :address => "MyText",
      :city => "MyString",
      :country => "MyString",
      :pin => 1,
      :phone_no => 1,
      :notes_to_studio => "MyText",
      :gallery => nil,
      :studio_internal_notes => "MyText",
      :status => "MyString"
    ))
  end

  it "renders the edit order form" do
    render

    assert_select "form[action=?][method=?]", order_path(@order), "post" do

      assert_select "input#order_email_id[name=?]", "order[email_id]"

      assert_select "input#order_first_name[name=?]", "order[first_name]"

      assert_select "input#order_last_name[name=?]", "order[last_name]"

      assert_select "textarea#order_address[name=?]", "order[address]"

      assert_select "input#order_city[name=?]", "order[city]"

      assert_select "input#order_country[name=?]", "order[country]"

      assert_select "input#order_pin[name=?]", "order[pin]"

      assert_select "input#order_phone_no[name=?]", "order[phone_no]"

      assert_select "textarea#order_notes_to_studio[name=?]", "order[notes_to_studio]"

      assert_select "input#order_gallery_id[name=?]", "order[gallery_id]"

      assert_select "textarea#order_studio_internal_notes[name=?]", "order[studio_internal_notes]"

      assert_select "input#order_status[name=?]", "order[status]"
    end
  end
end
