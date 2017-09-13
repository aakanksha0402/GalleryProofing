require 'rails_helper'

RSpec.describe "galleries/new", type: :view do
  before(:each) do
    assign(:gallery, Gallery.new(
      :name => "MyString",
      :cover_url => "MyString",
      :archive => false
    ))
  end

  it "renders new gallery form" do
    render

    assert_select "form[action=?][method=?]", galleries_path, "post" do

      assert_select "input#gallery_name[name=?]", "gallery[name]"

      assert_select "input#gallery_cover_url[name=?]", "gallery[cover_url]"

      assert_select "input#gallery_archive[name=?]", "gallery[archive]"
    end
  end
end
