require 'rails_helper'

RSpec.describe "watermarks/index", type: :view do
  before(:each) do
    assign(:watermarks, [
      Watermark.create!(
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
      ),
      Watermark.create!(
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
      )
    ])
  end

  it "renders a list of watermarks" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Text Name".to_s, :count => 2
    assert_select "tr>td", :text => "Font Set".to_s, :count => 2
    assert_select "tr>td", :text => "Color".to_s, :count => 2
    assert_select "tr>td", :text => "Text Opacity Value".to_s, :count => 2
    assert_select "tr>td", :text => "Image Url".to_s, :count => 2
    assert_select "tr>td", :text => "Image Placement".to_s, :count => 2
    assert_select "tr>td", :text => "Size".to_s, :count => 2
    assert_select "tr>td", :text => "Image Opacity Value".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
