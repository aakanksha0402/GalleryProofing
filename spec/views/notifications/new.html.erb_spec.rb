require 'rails_helper'

RSpec.describe "notifications/new", type: :view do
  before(:each) do
    assign(:notification, Notification.new(
      :notification_from => "MyString",
      :id_from => 1,
      :brand => nil,
      :is_dismiss => false
    ))
  end

  it "renders new notification form" do
    render

    assert_select "form[action=?][method=?]", notifications_path, "post" do

      assert_select "input#notification_notification_from[name=?]", "notification[notification_from]"

      assert_select "input#notification_id_from[name=?]", "notification[id_from]"

      assert_select "input#notification_brand_id[name=?]", "notification[brand_id]"

      assert_select "input#notification_is_dismiss[name=?]", "notification[is_dismiss]"
    end
  end
end
