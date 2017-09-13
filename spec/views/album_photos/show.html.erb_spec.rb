require 'rails_helper'

RSpec.describe "album_photos/show", type: :view do
  before(:each) do
    @album_photo = assign(:album_photo, AlbumPhoto.create!(
      :album => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
