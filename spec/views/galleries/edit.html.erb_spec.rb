require 'rails_helper'

RSpec.describe "galleries/edit", type: :view do
  before(:each) do
    @gallery = assign(:gallery, Gallery.create!(
      :name => "MyString",
      :cover_url => "MyString",
      :archive => false
    ))
  end

  it "renders the edit gallery form" do
    render

    assert_select "form[action=?][method=?]", gallery_path(@gallery), "post" do

      assert_select "input#gallery_name[name=?]", "gallery[name]"

      assert_select "input#gallery_cover_url[name=?]", "gallery[cover_url]"

      assert_select "input#gallery_archive[name=?]", "gallery[archive]"
    end
  end
end
