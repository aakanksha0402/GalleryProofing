require 'rails_helper'

RSpec.describe "notifications/edit", type: :view do
  before(:each) do
    @notification = assign(:notification, Notification.create!(
      :notification_from => "MyString",
      :id_from => 1,
      :brand => nil,
      :is_dismiss => false
    ))
  end

  it "renders the edit notification form" do
    render

    assert_select "form[action=?][method=?]", notification_path(@notification), "post" do

      assert_select "input#notification_notification_from[name=?]", "notification[notification_from]"

      assert_select "input#notification_id_from[name=?]", "notification[id_from]"

      assert_select "input#notification_brand_id[name=?]", "notification[brand_id]"

      assert_select "input#notification_is_dismiss[name=?]", "notification[is_dismiss]"
    end
  end
end
