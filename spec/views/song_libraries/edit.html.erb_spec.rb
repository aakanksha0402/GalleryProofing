require 'rails_helper'

RSpec.describe "song_libraries/edit", type: :view do
  before(:each) do
    @song_library = assign(:song_library, SongLibrary.create!())
  end

  it "renders the edit song_library form" do
    render

    assert_select "form[action=?][method=?]", song_library_path(@song_library), "post" do
    end
  end
end
