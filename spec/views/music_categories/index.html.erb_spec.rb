require 'rails_helper'

RSpec.describe "music_categories/index", type: :view do
  before(:each) do
    assign(:music_categories, [
      MusicCategory.create!(
        :name => "Name"
      ),
      MusicCategory.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of music_categories" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
