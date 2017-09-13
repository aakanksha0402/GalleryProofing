require 'rails_helper'

RSpec.describe "musics/index", type: :view do
  before(:each) do
    assign(:musics, [
      Music.create!(
        :title => "Title",
        :theme => "Theme",
        :style => "Style",
        :mood => "Mood",
        :type => "Type",
        :tempo => "Tempo",
        :instrument => "Instrument",
        :artist => "Artist",
        :music_plan => nil
      ),
      Music.create!(
        :title => "Title",
        :theme => "Theme",
        :style => "Style",
        :mood => "Mood",
        :type => "Type",
        :tempo => "Tempo",
        :instrument => "Instrument",
        :artist => "Artist",
        :music_plan => nil
      )
    ])
  end

  it "renders a list of musics" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Theme".to_s, :count => 2
    assert_select "tr>td", :text => "Style".to_s, :count => 2
    assert_select "tr>td", :text => "Mood".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "Tempo".to_s, :count => 2
    assert_select "tr>td", :text => "Instrument".to_s, :count => 2
    assert_select "tr>td", :text => "Artist".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
