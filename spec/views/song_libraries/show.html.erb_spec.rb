require 'rails_helper'

RSpec.describe "song_libraries/show", type: :view do
  before(:each) do
    @song_library = assign(:song_library, SongLibrary.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
