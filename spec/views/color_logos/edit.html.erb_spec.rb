require 'rails_helper'

RSpec.describe "color_logos/edit", type: :view do
  before(:each) do
    @color_logo = assign(:color_logo, ColorLogo.create!(
      :font_set => "MyString",
      :theme => "MyString",
      :primary_color => "MyString",
      :secondary_color => "MyString"
    ))
  end

  it "renders the edit color_logo form" do
    render

    assert_select "form[action=?][method=?]", color_logo_path(@color_logo), "post" do

      assert_select "input#color_logo_font_set[name=?]", "color_logo[font_set]"

      assert_select "input#color_logo_theme[name=?]", "color_logo[theme]"

      assert_select "input#color_logo_primary_color[name=?]", "color_logo[primary_color]"

      assert_select "input#color_logo_secondary_color[name=?]", "color_logo[secondary_color]"
    end
  end
end
