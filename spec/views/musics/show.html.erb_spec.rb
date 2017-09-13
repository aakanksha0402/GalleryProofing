require 'rails_helper'

RSpec.describe "musics/show", type: :view do
  before(:each) do
    @music = assign(:music, Music.create!(
      :title => "Title",
      :theme => "Theme",
      :style => "Style",
      :mood => "Mood",
      :type => "Type",
      :tempo => "Tempo",
      :instrument => "Instrument",
      :artist => "Artist",
      :music_plan => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Theme/)
    expect(rendered).to match(/Style/)
    expect(rendered).to match(/Mood/)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/Tempo/)
    expect(rendered).to match(/Instrument/)
    expect(rendered).to match(/Artist/)
    expect(rendered).to match(//)
  end
end
