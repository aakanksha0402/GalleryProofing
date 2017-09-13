require 'rails_helper'

RSpec.describe "watermarks/show", type: :view do
  before(:each) do
    @watermark = assign(:watermark, Watermark.create!(
      :name => "Name",
      :text_name => "Text Name",
      :font_set => "Font Set",
      :color => "Color",
      :text_opacity_value => "Text Opacity Value",
      :image_url => "Image Url",
      :image_placement => "Image Placement",
      :size => "Size",
      :image_opacity_value => "Image Opacity Value",
      :selected_as => false,
      :is_default => false,
      :brand => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Text Name/)
    expect(rendered).to match(/Font Set/)
    expect(rendered).to match(/Color/)
    expect(rendered).to match(/Text Opacity Value/)
    expect(rendered).to match(/Image Url/)
    expect(rendered).to match(/Image Placement/)
    expect(rendered).to match(/Size/)
    expect(rendered).to match(/Image Opacity Value/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
  end
end
