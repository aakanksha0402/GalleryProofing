require 'rails_helper'

RSpec.describe "watermarks/edit", type: :view do
  before(:each) do
    @watermark = assign(:watermark, Watermark.create!(
      :name => "MyString",
      :text_name => "MyString",
      :font_set => "MyString",
      :color => "MyString",
      :text_opacity_value => "MyString",
      :image_url => "MyString",
      :image_placement => "MyString",
      :size => "MyString",
      :image_opacity_value => "MyString",
      :selected_as => false,
      :is_default => false,
      :brand => nil
    ))
  end

  it "renders the edit watermark form" do
    render

    assert_select "form[action=?][method=?]", watermark_path(@watermark), "post" do

      assert_select "input#watermark_name[name=?]", "watermark[name]"

      assert_select "input#watermark_text_name[name=?]", "watermark[text_name]"

      assert_select "input#watermark_font_set[name=?]", "watermark[font_set]"

      assert_select "input#watermark_color[name=?]", "watermark[color]"

      assert_select "input#watermark_text_opacity_value[name=?]", "watermark[text_opacity_value]"

      assert_select "input#watermark_image_url[name=?]", "watermark[image_url]"

      assert_select "input#watermark_image_placement[name=?]", "watermark[image_placement]"

      assert_select "input#watermark_size[name=?]", "watermark[size]"

      assert_select "input#watermark_image_opacity_value[name=?]", "watermark[image_opacity_value]"

      assert_select "input#watermark_selected_as[name=?]", "watermark[selected_as]"

      assert_select "input#watermark_is_default[name=?]", "watermark[is_default]"

      assert_select "input#watermark_brand_id[name=?]", "watermark[brand_id]"
    end
  end
end
