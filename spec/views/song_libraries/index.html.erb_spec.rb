require 'rails_helper'

RSpec.describe "song_libraries/index", type: :view do
  before(:each) do
    assign(:song_libraries, [
      SongLibrary.create!(),
      SongLibrary.create!()
    ])
  end

  it "renders a list of song_libraries" do
    render
  end
end
