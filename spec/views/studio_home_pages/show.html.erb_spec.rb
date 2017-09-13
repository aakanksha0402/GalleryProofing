require 'rails_helper'

RSpec.describe "studio_home_pages/show", type: :view do
  before(:each) do
    @studio_home_page = assign(:studio_home_page, StudioHomePage.create!(
      :subdomain => "Subdomain",
      :color_logo => nil,
      :homepage_layout => "Homepage Layout",
      :event_list => false,
      :email_field => false,
      :sort_on => "Sort On",
      :about => "About",
      :fb_url => "Fb Url",
      :twitter_username => "Twitter Username",
      :intagram_username => "Intagram Username",
      :pinterest_username => "Pinterest Username",
      :show_about => false,
      :show_phone => false,
      :show_address => false,
      :show_email => false,
      :show_website_link => false,
      :brand => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Subdomain/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Homepage Layout/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Sort On/)
    expect(rendered).to match(/About/)
    expect(rendered).to match(/Fb Url/)
    expect(rendered).to match(/Twitter Username/)
    expect(rendered).to match(/Intagram Username/)
    expect(rendered).to match(/Pinterest Username/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
  end
end
