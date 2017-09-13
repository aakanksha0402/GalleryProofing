require 'rails_helper'

RSpec.describe "studio_home_pages/new", type: :view do
  before(:each) do
    assign(:studio_home_page, StudioHomePage.new(
      :subdomain => "MyString",
      :color_logo => nil,
      :homepage_layout => "MyString",
      :event_list => false,
      :email_field => false,
      :sort_on => "MyString",
      :about => "MyString",
      :fb_url => "MyString",
      :twitter_username => "MyString",
      :intagram_username => "MyString",
      :pinterest_username => "MyString",
      :show_about => false,
      :show_phone => false,
      :show_address => false,
      :show_email => false,
      :show_website_link => false,
      :brand => nil
    ))
  end

  it "renders new studio_home_page form" do
    render

    assert_select "form[action=?][method=?]", studio_home_pages_path, "post" do

      assert_select "input#studio_home_page_subdomain[name=?]", "studio_home_page[subdomain]"

      assert_select "input#studio_home_page_color_logo_id[name=?]", "studio_home_page[color_logo_id]"

      assert_select "input#studio_home_page_homepage_layout[name=?]", "studio_home_page[homepage_layout]"

      assert_select "input#studio_home_page_event_list[name=?]", "studio_home_page[event_list]"

      assert_select "input#studio_home_page_email_field[name=?]", "studio_home_page[email_field]"

      assert_select "input#studio_home_page_sort_on[name=?]", "studio_home_page[sort_on]"

      assert_select "input#studio_home_page_about[name=?]", "studio_home_page[about]"

      assert_select "input#studio_home_page_fb_url[name=?]", "studio_home_page[fb_url]"

      assert_select "input#studio_home_page_twitter_username[name=?]", "studio_home_page[twitter_username]"

      assert_select "input#studio_home_page_intagram_username[name=?]", "studio_home_page[intagram_username]"

      assert_select "input#studio_home_page_pinterest_username[name=?]", "studio_home_page[pinterest_username]"

      assert_select "input#studio_home_page_show_about[name=?]", "studio_home_page[show_about]"

      assert_select "input#studio_home_page_show_phone[name=?]", "studio_home_page[show_phone]"

      assert_select "input#studio_home_page_show_address[name=?]", "studio_home_page[show_address]"

      assert_select "input#studio_home_page_show_email[name=?]", "studio_home_page[show_email]"

      assert_select "input#studio_home_page_show_website_link[name=?]", "studio_home_page[show_website_link]"

      assert_select "input#studio_home_page_brand_id[name=?]", "studio_home_page[brand_id]"
    end
  end
end
