require 'rails_helper'

RSpec.describe "studio_home_pages/index", type: :view do
  before(:each) do
    assign(:studio_home_pages, [
      StudioHomePage.create!(
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
      ),
      StudioHomePage.create!(
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
      )
    ])
  end

  it "renders a list of studio_home_pages" do
    render
    assert_select "tr>td", :text => "Subdomain".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Homepage Layout".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Sort On".to_s, :count => 2
    assert_select "tr>td", :text => "About".to_s, :count => 2
    assert_select "tr>td", :text => "Fb Url".to_s, :count => 2
    assert_select "tr>td", :text => "Twitter Username".to_s, :count => 2
    assert_select "tr>td", :text => "Intagram Username".to_s, :count => 2
    assert_select "tr>td", :text => "Pinterest Username".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
