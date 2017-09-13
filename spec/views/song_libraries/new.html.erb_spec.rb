require 'rails_helper'

RSpec.describe "song_libraries/new", type: :view do
  before(:each) do
    assign(:song_library, SongLibrary.new())
  end

  it "renders new song_library form" do
    render

    assert_select "form[action=?][method=?]", song_libraries_path, "post" do
    end
  end
end
