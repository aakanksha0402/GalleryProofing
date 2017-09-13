require 'rails_helper'

RSpec.describe "music_categories/show", type: :view do
  before(:each) do
    @music_category = assign(:music_category, MusicCategory.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
