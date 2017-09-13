require 'rails_helper'

RSpec.describe "mobileapps/show", type: :view do
  before(:each) do
    @mobileapp = assign(:mobileapp, Mobileapp.create!(
      :name => "Name",
      :contact_info => false,
      :social_sharing => false,
      :layout => false,
      :language => "Language",
      :mobileapp_photo => nil,
      :color_logo => nil,
      :mobileapp_custom_link => nil,
      :gallery => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Language/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
