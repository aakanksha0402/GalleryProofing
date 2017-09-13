require 'rails_helper'

RSpec.describe "albums/edit", type: :view do
  before(:each) do
    @album = assign(:album, Album.create!(
      :gallery => nil,
      :title => "MyString"
    ))
  end

  it "renders the edit album form" do
    render

    assert_select "form[action=?][method=?]", album_path(@album), "post" do

      assert_select "input#album_gallery_id[name=?]", "album[gallery_id]"

      assert_select "input#album_title[name=?]", "album[title]"
    end
  end
end
