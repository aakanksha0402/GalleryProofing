require 'rails_helper'

RSpec.describe "color_logos/index", type: :view do
  before(:each) do
    assign(:color_logos, [
      ColorLogo.create!(
        :font_set => "Font Set",
        :theme => "Theme",
        :primary_color => "Primary Color",
        :secondary_color => "Secondary Color"
      ),
      ColorLogo.create!(
        :font_set => "Font Set",
        :theme => "Theme",
        :primary_color => "Primary Color",
        :secondary_color => "Secondary Color"
      )
    ])
  end

  it "renders a list of color_logos" do
    render
    assert_select "tr>td", :text => "Font Set".to_s, :count => 2
    assert_select "tr>td", :text => "Theme".to_s, :count => 2
    assert_select "tr>td", :text => "Primary Color".to_s, :count => 2
    assert_select "tr>td", :text => "Secondary Color".to_s, :count => 2
  end
end
