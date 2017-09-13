require 'rails_helper'

RSpec.describe "notifications/index", type: :view do
  before(:each) do
    assign(:notifications, [
      Notification.create!(
        :notification_from => "Notification From",
        :id_from => 1,
        :brand => nil,
        :is_dismiss => false
      ),
      Notification.create!(
        :notification_from => "Notification From",
        :id_from => 1,
        :brand => nil,
        :is_dismiss => false
      )
    ])
  end

  it "renders a list of notifications" do
    render
    assert_select "tr>td", :text => "Notification From".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
