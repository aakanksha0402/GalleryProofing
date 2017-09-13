require 'rails_helper'

RSpec.describe "color_logos/show", type: :view do
  before(:each) do
    @color_logo = assign(:color_logo, ColorLogo.create!(
      :font_set => "Font Set",
      :theme => "Theme",
      :primary_color => "Primary Color",
      :secondary_color => "Secondary Color"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Font Set/)
    expect(rendered).to match(/Theme/)
    expect(rendered).to match(/Primary Color/)
    expect(rendered).to match(/Secondary Color/)
  end
end
