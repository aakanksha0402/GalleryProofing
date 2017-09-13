require 'rails_helper'

RSpec.describe "musics/edit", type: :view do
  before(:each) do
    @music = assign(:music, Music.create!(
      :title => "MyString",
      :theme => "MyString",
      :style => "MyString",
      :mood => "MyString",
      :type => "",
      :tempo => "MyString",
      :instrument => "MyString",
      :artist => "MyString",
      :music_plan => nil
    ))
  end

  it "renders the edit music form" do
    render

    assert_select "form[action=?][method=?]", music_path(@music), "post" do

      assert_select "input#music_title[name=?]", "music[title]"

      assert_select "input#music_theme[name=?]", "music[theme]"

      assert_select "input#music_style[name=?]", "music[style]"

      assert_select "input#music_mood[name=?]", "music[mood]"

      assert_select "input#music_type[name=?]", "music[type]"

      assert_select "input#music_tempo[name=?]", "music[tempo]"

      assert_select "input#music_instrument[name=?]", "music[instrument]"

      assert_select "input#music_artist[name=?]", "music[artist]"

      assert_select "input#music_music_plan_id[name=?]", "music[music_plan_id]"
    end
  end
end
