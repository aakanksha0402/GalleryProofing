require 'rails_helper'

RSpec.describe "albums/new", type: :view do
  before(:each) do
    assign(:album, Album.new(
      :gallery => nil,
      :title => "MyString"
    ))
  end

  it "renders new album form" do
    render

    assert_select "form[action=?][method=?]", albums_path, "post" do

      assert_select "input#album_gallery_id[name=?]", "album[gallery_id]"

      assert_select "input#album_title[name=?]", "album[title]"
    end
  end
end
