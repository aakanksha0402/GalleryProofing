require 'rails_helper'

RSpec.describe "album_photos/edit", type: :view do
  before(:each) do
    @album_photo = assign(:album_photo, AlbumPhoto.create!(
      :album => nil
    ))
  end

  it "renders the edit album_photo form" do
    render

    assert_select "form[action=?][method=?]", album_photo_path(@album_photo), "post" do

      assert_select "input#album_photo_album_id[name=?]", "album_photo[album_id]"
    end
  end
end
