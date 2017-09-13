require 'rails_helper'

RSpec.describe "notifications/show", type: :view do
  before(:each) do
    @notification = assign(:notification, Notification.create!(
      :notification_from => "Notification From",
      :id_from => 1,
      :brand => nil,
      :is_dismiss => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Notification From/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
