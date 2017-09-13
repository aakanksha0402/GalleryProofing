require 'rails_helper'

RSpec.describe "mobileapps/index", type: :view do
  before(:each) do
    assign(:mobileapps, [
      Mobileapp.create!(
        :name => "Name",
        :contact_info => false,
        :social_sharing => false,
        :layout => false,
        :language => "Language",
        :mobileapp_photo => nil,
        :color_logo => nil,
        :mobileapp_custom_link => nil,
        :gallery => nil
      ),
      Mobileapp.create!(
        :name => "Name",
        :contact_info => false,
        :social_sharing => false,
        :layout => false,
        :language => "Language",
        :mobileapp_photo => nil,
        :color_logo => nil,
        :mobileapp_custom_link => nil,
        :gallery => nil
      )
    ])
  end

  it "renders a list of mobileapps" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Language".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
